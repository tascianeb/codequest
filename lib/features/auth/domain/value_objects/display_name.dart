class DisplayName {
  DisplayName(String rawValue) : value = rawValue.trim() {
    if (value.length < 2) {
      throw ArgumentError('Nome deve ter pelo menos 2 caracteres.');
    }
  }

  final String value;
}
