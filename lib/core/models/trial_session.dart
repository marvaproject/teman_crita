enum TrialState { active, warning, expired }

class TrialSession {
  const TrialSession({required this.remainingSeconds});

  final int remainingSeconds;

  TrialState get state {
    if (remainingSeconds <= 0) return TrialState.expired;
    if (remainingSeconds < 120) return TrialState.warning;
    return TrialState.active;
  }

  String get clock {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}
