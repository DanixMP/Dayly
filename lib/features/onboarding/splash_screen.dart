import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';
import '../../state/onboarding_controller.dart';
import '../../theme/app_assets.dart';
import '../../theme/design_tokens.dart';
import '../../ui/motion/app_motion.dart';
import 'widgets/onboarding_carousel_art.dart';
import 'widgets/splash_cinema_art.dart';

/// Cinematic splash — film strip, viewfinder, logo reveal, then enter the app.
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _filmScroll;
  late final Animation<double> _lightSweep;
  late final Animation<double> _viewfinderDraw;
  late final Animation<double> _logoReveal;
  late final Animation<double> _titleOpacity;
  late final Animation<double> _taglineOpacity;
  late final Animation<double> _recordPulse;
  late final Animation<double> _exitFade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3400),
    );

    _filmScroll = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0, 0.62, curve: Curves.easeInOutCubic),
    );
    _lightSweep = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.08, 0.42, curve: AppMotion.curve),
    );
    _viewfinderDraw = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.12, 0.48, curve: AppMotion.curveEmphasized),
    );
    _logoReveal = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.32, 0.72, curve: AppMotion.curveSpring),
    );
    _titleOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.52, 0.72, curve: AppMotion.curve),
    );
    _taglineOpacity = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.64, 0.84, curve: AppMotion.curve),
    );
    _recordPulse = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.72, 1, curve: Curves.easeInOutSine),
    );
    _exitFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.88, 1, curve: Curves.easeIn),
    );

    _controller.forward().whenComplete(_finish);

    // Safety net if the animation is interrupted on a device.
    Future.delayed(const Duration(seconds: 6), () {
      if (mounted && _controller.status != AnimationStatus.completed) {
        _finish();
      }
    });
  }

  Future<void> _finish() async {
    if (!mounted) return;
    final done = ref.read(onboardingCompleteProvider);
    if (!mounted) return;
    context.go(done ? '/today' : '/onboarding');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final p = tokens.palette;
    final pulse = _recordPulse.value * 0.5 + 0.5 * (1 - _recordPulse.value);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final exitScale = 1 + _exitFade.value * 0.04;

        return Opacity(
          opacity: 1 - _exitFade.value * 0.96,
          child: Transform.scale(
            scale: exitScale,
            child: ColoredBox(
              color: p.background,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  OnboardingBackdrop(
                    page: _filmScroll.value * 3.2,
                    accent: p.accent,
                    background: p.background,
                  ),
                  SplashDustLayer(tick: _controller.value, accent: p.accent),
                  SplashLightSweep(
                    progress: _lightSweep.value,
                    accent: p.accent,
                  ),
                  SplashFilmStrip(
                    offset: _filmScroll.value,
                    accent: p.accent,
                    surface: p.surfaceElevated,
                  ),
                  SafeArea(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Transform.scale(
                            scale: _logoReveal.value.clamp(0.0, 1.2),
                            child: Opacity(
                              opacity: _logoReveal.value.clamp(0.0, 1.0),
                              child: SplashViewfinderFrame(
                                progress: _viewfinderDraw.value,
                                pulse: pulse,
                                accent: p.accent,
                                size: 220,
                                child: const AppLogo(size: 96, circular: true),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xl),
                          Opacity(
                            opacity: _titleOpacity.value,
                            child: Transform.translate(
                              offset: Offset(0, (1 - _titleOpacity.value) * 12),
                              child: Text(
                                t.appTitle,
                                style: tokens.type.monthHeader.copyWith(
                                  fontSize: 36,
                                  letterSpacing: -0.5,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.sm),
                          Opacity(
                            opacity: _taglineOpacity.value,
                            child: Transform.translate(
                              offset: Offset(
                                0,
                                (1 - _taglineOpacity.value) * 10,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSpacing.xl,
                                ),
                                child: Text(
                                  t.appTagline,
                                  textAlign: TextAlign.center,
                                  style: tokens.type.body.copyWith(
                                    fontSize: 15,
                                    color: p.textSecondary,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
