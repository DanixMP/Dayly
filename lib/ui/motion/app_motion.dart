import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

/// Shared motion tokens and entrance/transition helpers used across Dayly.
class AppMotion {
  const AppMotion._();

  static const Duration fast = Duration(milliseconds: 180);
  static const Duration normal = Duration(milliseconds: 320);
  static const Duration slow = Duration(milliseconds: 480);
  static const Duration tab = Duration(milliseconds: 360);
  static const Duration nav = Duration(milliseconds: 400);
  /// Curved bubble slide — slightly slower than Crystal for a softer feel.
  static const Duration curvedNav = Duration(milliseconds: 620);

  static const Duration staggerStep = Duration(milliseconds: 55);
  static const double slideOffset = 18;
  static const double tabSlideOffset = 0.04;

  static const Curve curve = Curves.easeOutCubic;
  static const Curve curveEmphasized = Curves.easeOutQuart;
  static const Curve curveSpring = Curves.easeOutBack;
  /// Nav indicator curve — must stay in [0, 1]; easeOutBack overshoots and
  /// breaks CrystalNavigationBar's [Align.widthFactor].
  static const Curve navCurve = Curves.easeOutQuart;
  static const Curve curvedNavCurve = Curves.easeInOutCubic;

  /// Fade + slide transition used by settings drill-down routes.
  static Widget fadeSlideTransition(
    Animation<double> animation,
    Widget child, {
    Offset? beginOffset,
  }) {
    final curved = CurvedAnimation(parent: animation, curve: curve);
    return FadeTransition(
      opacity: curved,
      child: SlideTransition(
        position: Tween<Offset>(
          begin: beginOffset ?? const Offset(tabSlideOffset, 0),
          end: Offset.zero,
        ).animate(curved),
        child: child,
      ),
    );
  }

  /// Slide + fade page transition for settings drill-down routes.
  static CustomTransitionPage<T> detailPage<T>({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: key,
      child: child,
      transitionDuration: normal,
      reverseTransitionDuration: fast,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return fadeSlideTransition(animation, child);
      },
    );
  }

  /// Branch container builder for [StatefulShellRoute] tab transitions.
  static Widget tabBranchContainer(
    BuildContext context,
    StatefulNavigationShell navigationShell,
    List<Widget> children,
  ) {
    return SwipableTabBranchContainer(
      currentIndex: navigationShell.currentIndex,
      onIndexChanged: navigationShell.goBranch,
      children: children,
    );
  }
}

/// Horizontal swipe between tab branches, synced with the bottom nav index.
class SwipableTabBranchContainer extends StatefulWidget {
  const SwipableTabBranchContainer({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
    required this.children,
  });

  final int currentIndex;
  final ValueChanged<int> onIndexChanged;
  final List<Widget> children;

  @override
  State<SwipableTabBranchContainer> createState() =>
      _SwipableTabBranchContainerState();
}

class _SwipableTabBranchContainerState extends State<SwipableTabBranchContainer> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.currentIndex);
  }

  @override
  void didUpdateWidget(SwipableTabBranchContainer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex == widget.currentIndex) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_pageController.hasClients) return;
      final page = _pageController.page?.round() ?? _pageController.initialPage;
      if (page == widget.currentIndex) return;
      _pageController.animateToPage(
        widget.currentIndex,
        duration: AppMotion.tab,
        curve: AppMotion.curveEmphasized,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      onPageChanged: widget.onIndexChanged,
      children: widget.children,
    );
  }
}

/// Fades and slides a child in with a staggered delay based on [index].
class StaggeredEntrance extends StatefulWidget {
  const StaggeredEntrance({
    super.key,
    required this.index,
    required this.child,
    this.offsetY = AppMotion.slideOffset,
  });

  final int index;
  final Widget child;
  final double offsetY;

  @override
  State<StaggeredEntrance> createState() => _StaggeredEntranceState();
}

class _StaggeredEntranceState extends State<StaggeredEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: AppMotion.normal);
    final curved = CurvedAnimation(parent: _controller, curve: AppMotion.curve);
    _opacity = Tween<double>(begin: 0, end: 1).animate(curved);
    _offset = Tween<Offset>(
      begin: Offset(0, widget.offsetY / 100),
      end: Offset.zero,
    ).animate(curved);

    Future<void>.delayed(AppMotion.staggerStep * widget.index, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _offset, child: widget.child),
    );
  }
}

/// Wraps list children with staggered entrance animations.
class StaggeredList extends StatelessWidget {
  const StaggeredList({
    super.key,
    required this.children,
    this.startIndex = 0,
  });

  final List<Widget> children;
  final int startIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < children.length; i++)
          StaggeredEntrance(
            index: startIndex + i,
            child: children[i],
          ),
      ],
    );
  }
}
