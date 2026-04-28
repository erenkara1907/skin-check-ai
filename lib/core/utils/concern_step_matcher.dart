import '../../features/routine/domain/entities/routine_step_detail_entity.dart';

/// A matched routine step with its routine type.
class MatchedRoutineStep {
  const MatchedRoutineStep({
    required this.step,
    required this.routineType,
  });

  final RoutineStepDetailEntity step;

  /// "morning" or "evening".
  final String routineType;
}

/// Matches concern keywords against routine step reasons.
class ConcernStepMatcher {
  ConcernStepMatcher._();

  /// Known synonyms for each concern key → search terms in reason.
  static const _synonyms = <String, List<String>>{
    'dryness': ['kuruluk', 'kuru', 'nem', 'nemlendirici', 'dry'],
    'dehydration': ['dehidrasyon', 'nem', 'su kaybı', 'dehydrat'],
    'oiliness': ['yağ', 'sebum', 'parlama', 'oil'],
    'acne': ['akne', 'sivilce', 'acne'],
    'wrinkles': ['kırışıklık', 'yaşlanma', 'wrinkle', 'anti-aging'],
    'fine lines': ['ince çizgi', 'çizgi', 'fine line'],
    'spots': ['leke', 'spot', 'pigment'],
    'pores': ['gözenek', 'pore'],
    'redness': ['kızarıklık', 'kırmızı', 'redness'],
    'dark circles': ['koyu halka', 'göz altı', 'dark circle'],
    'uneven tone': ['dengesiz ton', 'ton', 'uneven'],
    'sagging': ['sarkma', 'sıkılaştır', 'sagging'],
    'sensitivity': ['hassas', 'tahriş', 'sensiti'],
    'hyperpigmentation': ['hiperpigmentasyon', 'pigment'],
    'texture': ['doku', 'pürüzsüz', 'texture'],
  };

  /// Returns routine steps that address the given [concern].
  static List<MatchedRoutineStep> match({
    required String concern,
    required List<RoutineStepDetailEntity> morningSteps,
    required List<RoutineStepDetailEntity> eveningSteps,
  }) {
    final key = concern.toLowerCase().trim();
    final searchTerms = _synonyms[key] ?? [key];
    final results = <MatchedRoutineStep>[];

    for (final step in morningSteps) {
      if (_matches(step.reason, searchTerms)) {
        results.add(MatchedRoutineStep(step: step, routineType: 'morning'));
      }
    }
    for (final step in eveningSteps) {
      if (_matches(step.reason, searchTerms)) {
        results.add(MatchedRoutineStep(step: step, routineType: 'evening'));
      }
    }
    return results;
  }

  static bool _matches(String reason, List<String> terms) {
    final lower = reason.toLowerCase();
    return terms.any((t) => lower.contains(t));
  }
}
