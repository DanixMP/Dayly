import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/app_localizations.dart';
import '../../state/onboarding_controller.dart';
import '../../theme/app_icons.dart';
import '../../theme/design_tokens.dart';
import '../../ui/app_widgets.dart';
import '../../ui/motion/app_motion.dart';
import '../../ui/ui_kit.dart';
import 'widgets/onboarding_carousel_art.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  late final PageController _pageController;
  int _page = 0;

  static const _pageCount = 4;
  static const _viewportFraction = 0.84;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: _viewportFraction);
    _pageController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!mounted) return;
    final current = _pageController.page?.round() ?? _page;
    if (current != _page) setState(() => _page = current);
  }

  @override
  void dispose() {
    _pageController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  Future<void> _finish() async {
    await ref.read(onboardingCompleteProvider.notifier).complete();
    if (mounted) context.go('/today');
  }

  void _next() {
    if (_page >= _pageCount - 1) {
      _finish();
      return;
    }
    _pageController.nextPage(
      duration: AppMotion.normal,
      curve: AppMotion.curveEmphasized,
    );
  }

  List<_OnboardingSlide> _slides(AppLocalizations t) => [
    _OnboardingSlide(
      scene: OnboardingScene.welcome,
      accent: const Color(0xFFE8A317),
      useLogo: true,
      title: t.onboardingWelcomeTitle,
      body: t.onboardingWelcomeBody,
    ),
    _OnboardingSlide(
      scene: OnboardingScene.record,
      accent: const Color(0xFFE86A6A),
      title: t.onboardingRecordTitle,
      body: t.onboardingRecordBody,
    ),
    _OnboardingSlide(
      scene: OnboardingScene.calendar,
      accent: const Color(0xFF6B8CFF),
      title: t.onboardingCalendarTitle,
      body: t.onboardingCalendarBody,
    ),
    _OnboardingSlide(
      scene: OnboardingScene.reminders,
      accent: const Color(0xFFFF9F43),
      title: t.onboardingRemindersTitle,
      body: t.onboardingRemindersBody,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context);
    final tokens = context.tokens;
    final p = tokens.palette;
    final slides = _slides(t);
    final isLast = _page >= _pageCount - 1;
    final pageOffset = _pageController.hasClients
        ? (_pageController.page ?? _page.toDouble())
        : _page.toDouble();

    return AppScaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          OnboardingBackdrop(
            page: pageOffset,
            accent: p.accent,
            background: p.background,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.sm,
                AppSpacing.md,
                AppSpacing.lg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OnboardingStoryProgress(
                    page: pageOffset,
                    pageCount: _pageCount,
                    accent: p.accent,
                    track: p.border.withValues(alpha: 0.45),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Text(
                        '${_page + 1} / $_pageCount',
                        style: tokens.type.caption.copyWith(
                          color: p.textSecondary,
                        ),
                      ),
                      const Spacer(),
                      AppButton(
                        variant: AppButtonVariant.ghost,
                        onPressed: _finish,
                        child: Text(t.onboardingSkip),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _pageCount,
                      onPageChanged: (index) => setState(() => _page = index),
                      itemBuilder: (context, index) {
                        return _OnboardingCard(
                          slide: slides[index],
                          index: index,
                          pageOffset: pageOffset,
                        );
                      },
                    ),
                  ),
                  if (_page == 0) ...[
                    const SizedBox(height: AppSpacing.xs),
                    _SwipeHint(label: t.onboardingSwipe, color: p.textSecondary),
                  ],
                  const SizedBox(height: AppSpacing.md),
                  _PageDots(
                    count: _pageCount,
                    page: pageOffset,
                    accent: p.accent,
                    idle: p.border.withValues(alpha: 0.55),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  AppButton(
                    variant: AppButtonVariant.primary,
                    expand: true,
                    onPressed: _next,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(isLast ? t.onboardingGetStarted : t.onboardingNext),
                        if (!isLast) ...[
                          const SizedBox(width: AppSpacing.xs),
                          Icon(AppIcons.chevronRight, size: 18, color: p.onAccent),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingSlide {
  const _OnboardingSlide({
    required this.scene,
    required this.accent,
    required this.title,
    required this.body,
    this.useLogo = false,
  });

  final OnboardingScene scene;
  final Color accent;
  final bool useLogo;
  final String title;
  final String body;
}

class _OnboardingCard extends StatelessWidget {
  const _OnboardingCard({
    required this.slide,
    required this.index,
    required this.pageOffset,
  });

  final _OnboardingSlide slide;
  final int index;
  final double pageOffset;

  @override
  Widget build(BuildContext context) {
    final tokens = context.tokens;
    final p = tokens.palette;
    final delta = (index - pageOffset).abs();
    final scale = 1 - delta * 0.07;
    final opacity = (1 - delta * 0.45).clamp(0.55, 1.0);
    final parallaxY = (index - pageOffset) * 22;
    final isActive = delta < 0.5;

    return Transform.translate(
      offset: Offset(0, parallaxY),
      child: Transform.scale(
        scale: scale,
        child: Opacity(
          opacity: opacity,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.xs,
              vertical: AppSpacing.sm,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(AppRadii.lg),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    p.surfaceElevated.withValues(alpha: 0.96),
                    p.surface.withValues(alpha: 0.88),
                  ],
                ),
                border: Border.all(
                  color: slide.accent.withValues(alpha: isActive ? 0.45 : 0.18),
                  width: isActive ? 1.5 : 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: slide.accent.withValues(alpha: isActive ? 0.14 : 0.05),
                    blurRadius: 28,
                    offset: const Offset(0, 14),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  AppSpacing.xl,
                  AppSpacing.lg,
                  AppSpacing.lg,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OnboardingSceneArt(
                      scene: slide.scene,
                      accent: slide.accent,
                      isActive: isActive,
                      useLogo: slide.useLogo,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      slide.title,
                      textAlign: TextAlign.center,
                      style: tokens.type.monthHeader,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      slide.body,
                      textAlign: TextAlign.center,
                      style: tokens.type.body.copyWith(color: p.textSecondary),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _SwipeHint extends StatefulWidget {
  const _SwipeHint({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  State<_SwipeHint> createState() => _SwipeHintState();
}

class _SwipeHintState extends State<_SwipeHint>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(_controller.value * 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(AppIcons.chevronRight, size: 16, color: widget.color),
              const SizedBox(width: 4),
              Text(
                widget.label,
                style: context.tokens.type.caption.copyWith(
                  color: widget.color,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({
    required this.count,
    required this.page,
    required this.accent,
    required this.idle,
  });

  final int count;
  final double page;
  final Color accent;
  final Color idle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          AnimatedContainer(
            duration: AppMotion.fast,
            curve: AppMotion.curve,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: i == page.round() ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: Color.lerp(idle, accent, i == page.round() ? 1.0 : 0.35),
              borderRadius: BorderRadius.circular(99),
            ),
          ),
      ],
    );
  }
}
