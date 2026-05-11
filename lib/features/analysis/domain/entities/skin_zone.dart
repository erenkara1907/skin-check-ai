/// The 7 facial zones analyzed by SkinCheck AI.
enum SkinZone {
  forehead('forehead', 'Alın'),
  leftCheek('left_cheek', 'Sol Yanak'),
  rightCheek('right_cheek', 'Sağ Yanak'),
  nose('nose', 'Burun'),
  chin('chin', 'Çene'),
  underEyes('under_eyes', 'Göz Altı'),
  jawline('jawline', 'Çene Hattı');

  const SkinZone(this.value, this.label);

  /// Database / API value.
  final String value;

  /// Default display label (Turkish fallback).
  final String label;

  /// Parse from API/DB string value.
  static SkinZone fromValue(String value) {
    return SkinZone.values.firstWhere(
      (z) => z.value == value,
      orElse: () => SkinZone.forehead,
    );
  }
}
