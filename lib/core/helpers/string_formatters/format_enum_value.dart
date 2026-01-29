String formatEnumValue(String? enumValue) {
  if (enumValue == null || enumValue.trim().isEmpty) return '';

  final words = enumValue.trim().split(RegExp(r'[_\s]+'));

  final capitalizedWords = words.map((word) {
    if (word.isEmpty) return '';
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).where((word) => word.isNotEmpty);

  return capitalizedWords.join(' ');
}

String unformatEnumValue(String? friendlyValue) {
  if (friendlyValue == null || friendlyValue.trim().isEmpty) return '';

  return friendlyValue
      .trim()
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .map((word) => word.toUpperCase())
      .join('_');
}

