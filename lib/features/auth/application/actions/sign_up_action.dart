import 'package:codequest/features/auth/domain/entities/auth_user.dart';
import 'package:codequest/features/auth/domain/repositories/auth_repository_contract.dart';
import 'package:codequest/features/auth/domain/value_objects/display_name.dart';
import 'package:codequest/features/auth/domain/value_objects/email_address.dart';
import 'package:codequest/features/auth/domain/value_objects/password.dart';

class SignUpAction {
  SignUpAction(this._repository);

  final AuthRepositoryContract _repository;

  Future<AuthUser> call({
    required String email,
    required String password,
    required String name,
  }) {
    return _repository.signUp(
      email: EmailAddress(email),
      password: Password(password),
      name: DisplayName(name),
    );
  }
}
