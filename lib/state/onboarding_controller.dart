import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'settings_controller.dart';

class OnboardingNotifier extends Notifier<bool> {
  static const _kComplete = 'onboarding_complete';

  @override
  bool build() {
    return ref.read(sharedPreferencesProvider).getBool(_kComplete) ?? false;
  }

  Future<void> complete() async {
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(_kComplete, true);
    state = true;
  }
}

final onboardingCompleteProvider =
    NotifierProvider<OnboardingNotifier, bool>(OnboardingNotifier.new);
