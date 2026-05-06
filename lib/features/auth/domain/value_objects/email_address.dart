class EmailAddress {
  EmailAddress(String rawValue) : value = rawValue.trim().toLowerCase() {
    if (value.isEmpty || !value.contains('@')) {
      throw ArgumentError('E-mail inválido.');
    }
  }

  final String value;
}
