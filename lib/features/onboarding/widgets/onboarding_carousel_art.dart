import 'dart:math' as math;

import 'package:flutter/widgets.dart';

import '../../../theme/app_assets.dart';
import '../../../theme/design_tokens.dart';

enum OnboardingScene { welcome, record, calendar, reminders }

/// Parallax backdrop — soft orbs drift at different speeds while swiping.
class OnboardingBackdrop extends StatelessWidget {
  const OnboardingBackdrop({
    super.key,
    required this.page,
    required this.accent,
    required this.background,
  });

  final double page;
  final Color accent;
  final Color background;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _BackdropPainter(
        page: page,
        accent: accent,
        background: background,
      ),
      size: Size.infinite,
    );
  }
}

class _BackdropPainter extends CustomPainter {
  _BackdropPainter({
    required this.page,
    required this.accent,
    required this.background,
  });

  final double page;
  final Color accent;
  final Color background;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = background);

    final orbs = [
      _Orb(0.18, 0.12, 0.42, 0.08, accent.withValues(alpha: 0.22)),
      _Orb(0.82, 0.18, 0.28, 0.12, accent.withValues(alpha: 0.14)),
      _Orb(0.62, 0.72, 0.36, 0.06, accent.withValues(alpha: 0.1)),
      _Orb(0.12, 0.78, 0.24, 0.1, accent.withValues(alpha: 0.12)),
    ];

    for (var i = 0; i < orbs.length; i++) {
      final orb = orbs[i];
      final drift = math.sin((page + i * 0.7) * math.pi * 0.5) * 28;
      final center = Offset(
        size.width * orb.x + drift,
        size.height * orb.y - drift * 0.4,
      );
      final paint = Paint()
        ..shader = RadialGradient(
          colors: [orb.color, orb.color.withValues(alpha: 0)],
        ).createShader(Rect.fromCircle(center: center, radius: size.width * orb.r));
      canvas.drawCircle(center, size.width * orb.r, paint);
    }

    // Film perforations along the top edge.
    final perfPaint = Paint()..color = accent.withValues(alpha: 0.06);
    for (var x = -page * 18; x < size.width + 40; x += 22) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, 8, 10, 6),
          const Radius.circular(2),
        ),
        perfPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _BackdropPainter oldDelegate) =>
      oldDelegate.page != page || oldDelegate.accent != accent;
}

class _Orb {
  const _Orb(this.x, this.y, this.r, this.speed, this.color);
  final double x;
  final double y;
  final double r;
  final double speed;
  final Color color;
}

/// Animated scene illustration for each onboarding slide.
class OnboardingSceneArt extends StatefulWidget {
  const OnboardingSceneArt({
    super.key,
    required this.scene,
    required this.accent,
    required this.isActive,
    this.useLogo = false,
  });

  final OnboardingScene scene;
  final Color accent;
  final bool isActive;
  final bool useLogo;

  @override
  State<OnboardingSceneArt> createState() => _OnboardingSceneArtState();
}

class _OnboardingSceneArtState extends State<OnboardingSceneArt>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    );
    if (widget.isActive) _controller.repeat();
  }

  @override
  void didUpdateWidget(covariant OnboardingSceneArt oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.isActive && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      width: double.infinity,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          if (widget.useLogo) {
            return _WelcomeLogoScene(
              tick: _controller.value,
              accent: widget.accent,
            );
          }
          return CustomPaint(
            painter: switch (widget.scene) {
              OnboardingScene.welcome => _WelcomeScenePainter(
                  tick: _controller.value,
                  accent: widget.accent,
                ),
              OnboardingScene.record => _RecordScenePainter(
                  tick: _controller.value,
                  accent: widget.accent,
                ),
              OnboardingScene.calendar => _CalendarScenePainter(
                  tick: _controller.value,
                  accent: widget.accent,
                ),
              OnboardingScene.reminders => _ReminderScenePainter(
                  tick: _controller.value,
                  accent: widget.accent,
                ),
            },
          );
        },
      ),
    );
  }
}

class _WelcomeLogoScene extends StatelessWidget {
  const _WelcomeLogoScene({required this.tick, required this.accent});

  final double tick;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final angle = tick * math.pi * 2;
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Transform.rotate(
          angle: angle * 0.15,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: accent.withValues(alpha: 0.25), width: 2),
            ),
          ),
        ),
        Transform.rotate(
          angle: -angle * 0.25,
          child: Container(
            width: 156,
            height: 156,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: accent.withValues(alpha: 0.35),
                width: 1.5,
              ),
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(math.cos(angle) * 14, math.sin(angle) * 10),
          child: const AppLogo(size: 112),
        ),
        for (var i = 0; i < 6; i++)
          Transform.rotate(
            angle: angle + i * math.pi / 3,
            child: Transform.translate(
              offset: const Offset(0, -92),
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accent.withValues(alpha: 0.35 + (i % 2) * 0.2),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _WelcomeScenePainter extends CustomPainter {
  _WelcomeScenePainter({required this.tick, required this.accent});

  final double tick;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final reelR = size.shortestSide * 0.34;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(tick * math.pi * 2 * 0.08);

    final reel = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..color = accent.withValues(alpha: 0.55);
    canvas.drawCircle(Offset.zero, reelR, reel);

    for (var i = 0; i < 8; i++) {
      final a = i * math.pi / 4;
      canvas.drawLine(
        Offset(math.cos(a) * (reelR - 12), math.sin(a) * (reelR - 12)),
        Offset(math.cos(a) * (reelR + 8), math.sin(a) * (reelR + 8)),
        reel..strokeWidth = 2,
      );
    }

    final heart = Path()
      ..moveTo(0, reelR * 0.15)
      ..cubicTo(reelR * 0.5, -reelR * 0.45, reelR * 0.95, reelR * 0.2, 0, reelR * 0.85)
      ..cubicTo(-reelR * 0.95, reelR * 0.2, -reelR * 0.5, -reelR * 0.45, 0, reelR * 0.15);
    canvas.drawPath(
      heart,
      Paint()
        ..color = accent.withValues(alpha: 0.85)
        ..style = PaintingStyle.fill,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _WelcomeScenePainter oldDelegate) =>
      oldDelegate.tick != tick;
}

class _RecordScenePainter extends CustomPainter {
  _RecordScenePainter({required this.tick, required this.accent});

  final double tick;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final pulse = 0.5 + 0.5 * math.sin(tick * math.pi * 2);

    for (var ring = 3; ring >= 1; ring--) {
      final r = size.shortestSide * (0.22 + ring * 0.1) + pulse * 6;
      canvas.drawCircle(
        center,
        r,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = accent.withValues(alpha: 0.12 * ring),
      );
    }

    canvas.drawCircle(
      center,
      size.shortestSide * 0.28,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 4
        ..color = accent,
    );

    canvas.drawCircle(
      center,
      size.shortestSide * (0.16 + pulse * 0.02),
      Paint()..color = const Color(0xFFF5F5F5),
    );

    final arc = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFE86A6A);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: size.shortestSide * 0.28),
      -math.pi / 2,
      tick * math.pi * 1.6,
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(covariant _RecordScenePainter oldDelegate) =>
      oldDelegate.tick != tick;
}

class _CalendarScenePainter extends CustomPainter {
  _CalendarScenePainter({required this.tick, required this.accent});

  final double tick;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final cols = 4;
    final rows = 3;
    final cell = size.shortestSide * 0.17;
    final gap = 8.0;
    final gridW = cols * cell + (cols - 1) * gap;
    final gridH = rows * cell + (rows - 1) * gap;
    final origin = Offset(
      (size.width - gridW) / 2,
      (size.height - gridH) / 2,
    );

    final highlight = (tick * 12).floor() % 12;

    for (var r = 0; r < rows; r++) {
      for (var c = 0; c < cols; c++) {
        final i = r * cols + c;
        final rect = Rect.fromLTWH(
          origin.dx + c * (cell + gap),
          origin.dy + r * (cell + gap),
          cell,
          cell,
        );
        final active = i == highlight;
        canvas.drawRRect(
          RRect.fromRectAndRadius(rect, const Radius.circular(10)),
          Paint()
            ..color = active
                ? accent.withValues(alpha: 0.85)
                : accent.withValues(alpha: 0.12),
        );
        if (active) {
          canvas.drawCircle(
            rect.center + Offset(0, cell * 0.18),
            cell * 0.12,
            Paint()..color = const Color(0xFFF5F5F5),
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CalendarScenePainter oldDelegate) =>
      oldDelegate.tick != tick;
}

class _ReminderScenePainter extends CustomPainter {
  _ReminderScenePainter({required this.tick, required this.accent});

  final double tick;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final swing = math.sin(tick * math.pi * 2) * 0.12;

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(swing);

    final bell = Path()
      ..moveTo(-36, -20)
      ..quadraticBezierTo(-42, 18, -28, 38)
      ..lineTo(28, 38)
      ..quadraticBezierTo(42, 18, 36, -20)
      ..close();
    canvas.drawPath(
      bell,
      Paint()..color = accent.withValues(alpha: 0.9),
    );
    canvas.drawCircle(
      const Offset(0, -26),
      8,
      Paint()..color = accent,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(-14, 38, 28, 8),
        const Radius.circular(4),
      ),
      Paint()..color = accent.withValues(alpha: 0.7),
    );
    canvas.restore();

    for (var i = 0; i < 3; i++) {
      final wave = size.shortestSide * (0.34 + i * 0.12 + tick * 0.08);
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: wave % (size.shortestSide * 0.5)),
        -0.5,
        1.0,
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2
          ..color = accent.withValues(alpha: 0.18 - i * 0.04),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ReminderScenePainter oldDelegate) =>
      oldDelegate.tick != tick;
}

/// Instagram-style segmented progress for the carousel.
class OnboardingStoryProgress extends StatelessWidget {
  const OnboardingStoryProgress({
    super.key,
    required this.page,
    required this.pageCount,
    required this.accent,
    required this.track,
  });

  final double page;
  final int pageCount;
  final Color accent;
  final Color track;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < pageCount; i++)
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: i == pageCount - 1 ? 0 : 5),
              child: _SegmentBar(
                fill: _segmentFill(i, page),
                accent: accent,
                track: track,
              ),
            ),
          ),
      ],
    );
  }

  double _segmentFill(int index, double page) {
    if (page >= index + 1) return 1;
    if (page <= index) return 0;
    return page - index;
  }
}

class _SegmentBar extends StatelessWidget {
  const _SegmentBar({
    required this.fill,
    required this.accent,
    required this.track,
  });

  final double fill;
  final Color accent;
  final Color track;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(AppRadii.pill),
      child: SizedBox(
        height: 4,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(color: track),
            Align(
              alignment: Alignment.centerLeft,
              child: FractionallySizedBox(
                widthFactor: fill.clamp(0.0, 1.0),
                child: ColoredBox(color: accent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
