class Password {
  Password(String rawValue) : value = rawValue {
    if (value.length < 6) {
      throw ArgumentError('A senha deve ter no mínimo 6 caracteres.');
    }
  }

  final String value;
}
