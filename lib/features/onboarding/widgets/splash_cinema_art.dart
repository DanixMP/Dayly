import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Scrolling film strip with perforations — moves during splash intro.
class SplashFilmStrip extends StatelessWidget {
  const SplashFilmStrip({
    super.key,
    required this.offset,
    required this.accent,
    required this.surface,
  });

  final double offset;
  final Color accent;
  final Color surface;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _FilmStripPainter(
        offset: offset,
        accent: accent,
        surface: surface,
      ),
      size: Size.infinite,
    );
  }
}

class _FilmStripPainter extends CustomPainter {
  _FilmStripPainter({
    required this.offset,
    required this.accent,
    required this.surface,
  });

  final double offset;
  final Color accent;
  final Color surface;

  @override
  void paint(Canvas canvas, Size size) {
    final stripH = size.height * 0.18;
    final top = size.height * 0.72;
    final rect = Rect.fromLTWH(0, top, size.width, stripH);

    canvas.drawRect(
      rect,
      Paint()..color = surface.withValues(alpha: 0.55),
    );

    final holePaint = Paint()..color = accent.withValues(alpha: 0.08);
    for (var x = -offset * size.width * 1.4; x < size.width + 40; x += 18) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, top + 6, 10, stripH - 12),
          const Radius.circular(2),
        ),
        holePaint,
      );
    }

    const frameW = 52.0;
    final frameH = stripH - 28;
    final startX = -offset * size.width * 2.2;

    for (var i = 0; i < 24; i++) {
      final x = startX + i * (frameW + 10);
      if (x > size.width + frameW || x + frameW < -20) continue;

      final frameRect = Rect.fromLTWH(x, top + 14, frameW, frameH);
      final warmth = (i % 4) / 4;

      canvas.drawRRect(
        RRect.fromRectAndRadius(frameRect, const Radius.circular(6)),
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              accent.withValues(alpha: 0.18 + warmth * 0.12),
              accent.withValues(alpha: 0.06),
            ],
          ).createShader(frameRect),
      );

      canvas.drawRRect(
        RRect.fromRectAndRadius(frameRect, const Radius.circular(6)),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = accent.withValues(alpha: 0.22),
      );

      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x + 8, top + frameH * 0.55, frameW - 16, 4),
          const Radius.circular(2),
        ),
        Paint()..color = accent.withValues(alpha: 0.35),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _FilmStripPainter oldDelegate) =>
      oldDelegate.offset != offset;
}

/// Camera viewfinder corners that draw themselves around the logo.
class SplashViewfinderFrame extends StatelessWidget {
  const SplashViewfinderFrame({
    super.key,
    required this.progress,
    required this.pulse,
    required this.accent,
    required this.size,
    required this.child,
  });

  final double progress;
  final double pulse;
  final Color accent;
  final double size;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _ViewfinderPainter(
              progress: progress,
              pulse: pulse,
              accent: accent,
            ),
          ),
          Transform.scale(
            scale: 0.88 + pulse * 0.04,
            child: child,
          ),
        ],
      ),
    );
  }
}

class _ViewfinderPainter extends CustomPainter {
  _ViewfinderPainter({
    required this.progress,
    required this.pulse,
    required this.accent,
  });

  final double progress;
  final double pulse;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final inset = size.width * 0.08;
    final rect = Rect.fromLTWH(
      inset,
      inset,
      size.width - inset * 2,
      size.height - inset * 2,
    );

    final corner = size.width * 0.16 * progress;
    final paint = Paint()
      ..color = accent.withValues(alpha: 0.75 + pulse * 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.8
      ..strokeCap = StrokeCap.round;

    _corner(canvas, rect.topLeft, corner, 1, 1, paint);
    _corner(canvas, rect.topRight, corner, -1, 1, paint);
    _corner(canvas, rect.bottomLeft, corner, 1, -1, paint);
    _corner(canvas, rect.bottomRight, corner, -1, -1, paint);

    canvas.drawCircle(
      rect.center,
      size.width * (0.34 + pulse * 0.03),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..color = accent.withValues(alpha: 0.12 + pulse * 0.08),
    );

    canvas.drawCircle(
      rect.center,
      5 + pulse * 2,
      Paint()..color = accent.withValues(alpha: 0.55 + pulse * 0.25),
    );
  }

  void _corner(
    Canvas canvas,
    Offset origin,
    double len,
    int dx,
    int dy,
    Paint paint,
  ) {
    canvas.drawLine(origin, origin + Offset(len * dx, 0), paint);
    canvas.drawLine(origin, origin + Offset(0, len * dy), paint);
  }

  @override
  bool shouldRepaint(covariant _ViewfinderPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.pulse != pulse;
}

/// Soft light sweep across the splash on entry.
class SplashLightSweep extends StatelessWidget {
  const SplashLightSweep({
    super.key,
    required this.progress,
    required this.accent,
  });

  final double progress;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _LightSweepPainter(progress: progress, accent: accent),
      size: Size.infinite,
    );
  }
}

class _LightSweepPainter extends CustomPainter {
  _LightSweepPainter({required this.progress, required this.accent});

  final double progress;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    if (progress <= 0) return;

    final x = size.width * (-0.35 + progress * 1.5);
    final rect = Rect.fromLTWH(x, 0, size.width * 0.45, size.height);
    final paint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          accent.withValues(alpha: 0),
          accent.withValues(alpha: 0.07),
          accent.withValues(alpha: 0),
        ],
      ).createShader(rect);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant _LightSweepPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

/// Floating dust motes for a cinematic feel.
class SplashDustLayer extends StatelessWidget {
  const SplashDustLayer({
    super.key,
    required this.tick,
    required this.accent,
  });

  final double tick;
  final Color accent;

  static const _seeds = [
    (0.12, 0.22, 2.0),
    (0.28, 0.68, 1.5),
    (0.44, 0.35, 2.5),
    (0.58, 0.78, 1.8),
    (0.72, 0.18, 2.2),
    (0.86, 0.55, 1.6),
    (0.34, 0.88, 2.0),
    (0.91, 0.32, 1.4),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DustPainter(tick: tick, accent: accent, seeds: _seeds),
      size: Size.infinite,
    );
  }
}

class _DustPainter extends CustomPainter {
  _DustPainter({
    required this.tick,
    required this.accent,
    required this.seeds,
  });

  final double tick;
  final Color accent;
  final List<(double, double, double)> seeds;

  @override
  void paint(Canvas canvas, Size size) {
    for (var i = 0; i < seeds.length; i++) {
      final (x, y, r) = seeds[i];
      final drift = math.sin(tick * math.pi * 2 + i) * 6;
      canvas.drawCircle(
        Offset(size.width * x + drift, size.height * y - drift * 0.5),
        r,
        Paint()..color = accent.withValues(alpha: 0.14),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _DustPainter oldDelegate) =>
      oldDelegate.tick != tick;
}
