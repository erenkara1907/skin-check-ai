/// Skin concerns selectable during onboarding (multi-select).
enum SkinConcern {
  acne('acne', 'Akne'),
  wrinkles('wrinkles', 'Kırışıklık'),
  spots('spots', 'Leke'),
  pores('pores', 'Gözenekler'),
  dryness('dryness', 'Kuruluk'),
  oiliness('oiliness', 'Yağlanma'),
  darkCircles('dark_circles', 'Koyu Halka'),
  redness('redness', 'Kızarıklık');

  const SkinConcern(this.value, this.label);

  /// Database value stored in skin_concerns array.
  final String value;

  /// Turkish display label.
  final String label;

  /// Parse from database string value.
  static SkinConcern? fromValue(String? value) {
    if (value == null) return null;
    return SkinConcern.values.where((e) => e.value == value).firstOrNull;
  }

  /// Parse list of database values.
  static List<SkinConcern> fromValues(List<String> values) {
    return values
        .map(SkinConcern.fromValue)
        .whereType<SkinConcern>()
        .toList();
  }
}
