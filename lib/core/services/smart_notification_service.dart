/// Generates personalized notification messages based on user context.
class SmartNotificationService {
  SmartNotificationService._();

  /// Returns a personalized morning notification message.
  static ({String title, String body}) morningMessage({
    required int currentStreak,
    required bool missedYesterdayEvening,
  }) {
    if (missedYesterdayEvening) {
      return (
        title: 'Günaydın! ☀️',
        body: 'Dün akşam rutinini atladın ama bugün yeni bir başlangıç! '
            'Sabah rutinine başla.',
      );
    }
    if (currentStreak >= 30) {
      return (
        title: 'Efsane seri devam ediyor! 🔥',
        body: '$currentStreak gün üst üste! Bugün de rutinine sadık kal.',
      );
    }
    if (currentStreak >= 7) {
      return (
        title: 'Harika gidiyorsun! ☀️',
        body: '$currentStreak günlük serin var. Sabah rutinine başla!',
      );
    }
    // Rotate based on day of week
    final day = DateTime.now().weekday;
    return _morningPool[day % _morningPool.length];
  }

  /// Returns a personalized evening notification message.
  static ({String title, String body}) eveningMessage({
    required int currentStreak,
    required bool completedMorning,
  }) {
    if (completedMorning) {
      return (
        title: 'Akşam Rutini Zamanı 🌙',
        body: 'Sabah rutinini tamamladın, şimdi akşam rutinine geç!',
      );
    }
    if (currentStreak > 0) {
      return (
        title: 'Seriyi kırma! 🌙',
        body: '$currentStreak günlük serini devam ettir. '
            'Akşam rutinine başla.',
      );
    }
    return (
      title: 'Akşam Rutini Zamanı 🌙',
      body: 'Günü temiz bitir! Akşam bakım rutinine başla.',
    );
  }

  /// Returns a streak milestone message, or null if not a milestone.
  static ({String title, String body})? streakMilestone(int streak) {
    final milestones = _streakMilestones[streak];
    return milestones;
  }

  /// Returns a score improvement celebration message.
  static ({String title, String body})? scoreImprovement({
    required double previousScore,
    required double currentScore,
  }) {
    final diff = currentScore - previousScore;
    if (diff < 5) return null;
    final rounded = diff.round();
    return (
      title: 'Cilt Skorun Yükseldi! 🎉',
      body: 'Skorun $rounded puan arttı! Rutinlerin işe yarıyor.',
    );
  }

  static const _morningPool = [
    (
      title: 'Sabah Rutinin Hazır ☀️',
      body: 'Güne bakımlı başla! Sabah rutinine göz at.',
    ),
    (
      title: 'Günaydın! ☀️',
      body: 'Cildin seni bekliyor. Sabah bakım rutinine başla.',
    ),
    (
      title: 'Bugün cildin için ne yaptın? ☀️',
      body: 'Sabah rutinini tamamlayarak güne enerjik başla!',
    ),
    (
      title: 'Işıltılı bir gün seni bekliyor ☀️',
      body: 'SPF sürmeden çıkma! Sabah rutinine göz at.',
    ),
    (
      title: 'Sabah bakımı zamanı ☀️',
      body: 'Düzenli bakım, güzel sonuçlar getirir. Başla!',
    ),
  ];

  static const _streakMilestones = <int, ({String title, String body})>{
    7: (
      title: '7 Gün Seri! 🔥',
      body: 'Bir haftadır aksatmadın! Cildin teşekkür ediyor.',
    ),
    14: (
      title: '14 Gün Seri! 🔥🔥',
      body: '2 haftadır rutinine sadıksın. Harika gidiyorsun!',
    ),
    30: (
      title: '30 Gün Ustası! 🏆',
      body: 'Bir aydır düzenli bakım yapıyorsun. Sonuçları görmeye başladın mı?',
    ),
    60: (
      title: '60 Gün Efsanesi! ⭐',
      body: '2 aydır aksatmadın. Cildin sana minnettardır!',
    ),
    100: (
      title: '100 Gün! 🎖️',
      body: 'Efsanevi bir seri! 100 gün boyunca düzenli bakım yaptın.',
    ),
  };
}
