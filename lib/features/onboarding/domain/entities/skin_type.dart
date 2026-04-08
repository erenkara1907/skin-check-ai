/// Supported skin types for onboarding selection.
enum SkinType {
  normal('normal', 'Normal', 'Dengeli nem ve yağ oranı'),
  oily('oily', 'Yağlı', 'Parlama ve geniş gözenekler'),
  dry('dry', 'Kuru', 'Gerginlik ve pullanma hissi'),
  combination('combination', 'Karma', 'T-bölge yağlı, yanaklar kuru');

  const SkinType(this.value, this.label, this.description);

  /// Database value matching skin_type_enum.
  final String value;

  /// Turkish display label.
  final String label;

  /// Short Turkish description.
  final String description;

  /// Parse from database string value.
  static SkinType? fromValue(String? value) {
    if (value == null) return null;
    return SkinType.values.where((e) => e.value == value).firstOrNull;
  }
}
