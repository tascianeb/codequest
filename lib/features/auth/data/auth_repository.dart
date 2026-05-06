import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codequest/features/auth/domain/entities/auth_user.dart';
import 'package:codequest/features/auth/domain/repositories/auth_repository_contract.dart';
import 'package:codequest/features/auth/domain/value_objects/display_name.dart';
import 'package:codequest/features/auth/domain/value_objects/email_address.dart';
import 'package:codequest/features/auth/domain/value_objects/password.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository implements AuthRepositoryContract {
  AuthRepository({FirebaseAuth? auth, FirebaseFirestore? firestore})
      : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  @override
  Stream<AuthUser?> get authStateChanges {
    return _auth.authStateChanges().map(_mapFirebaseUser);
  }

  @override
  Future<AuthUser> signIn({required EmailAddress email, required Password password}) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.value,
      password: password.value,
    );

    final user = credential.user;
    if (user == null) {
      throw FirebaseAuthException(code: 'user-not-found', message: 'Usuário não encontrado.');
    }

    return _mapFirebaseUser(user)!;
  }

  @override
  Future<AuthUser> signUp({
    required EmailAddress email,
    required Password password,
    required DisplayName name,
  }) async {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email.value,
      password: password.value,
    );

    final user = credential.user;
    if (user != null) {
      await user.updateDisplayName(name.value);
      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'name': name.value,
        'leagueId': 'bronze-001',
        'createdAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));

      return _mapFirebaseUser(user)!;
    }

    throw FirebaseAuthException(code: 'unknown', message: 'Falha ao criar usuário.');
  }

  @override
  Future<void> signOut() {
    return _auth.signOut();
  }

  @override
  Future<void> sendPasswordReset(EmailAddress email) {
    return _auth.sendPasswordResetEmail(email: email.value);
  }

  AuthUser? _mapFirebaseUser(User? user) {
    if (user == null) {
      return null;
    }

    return AuthUser(
      uid: user.uid,
      email: user.email ?? '',
      displayName: user.displayName,
    );
  }
}
