import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/settings_controller.dart';
import 'design_tokens.dart';

/// Evicts a previously displayed background from Flutter's image cache.
Future<void> evictBackgroundImage(String? path) async {
  if (path == null || path.isEmpty) return;
  final file = File(path);
  if (!await file.exists()) return;
  await FileImage(file).evict();
}

/// Paints the solid color, optional photo, and readability scrim.
class AppBackgroundBackdrop extends ConsumerWidget {
  const AppBackgroundBackdrop({super.key, this.scrimAlpha});

  final double? scrimAlpha;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    if (!settings.colorCustomizerUnlocked) {
      return ColoredBox(color: context.tokens.palette.background);
    }

    final brightness = effectiveThemeBrightness(context, settings);
    final imagePath =
        settings.colorOverridesFor(brightness).backgroundImagePath;
    final p = context.tokens.palette;
    final scrim = scrimAlpha ?? (p.isDark ? 0.38 : 0.28);
    final file = imagePath == null ? null : File(imagePath);
    final hasImage = file != null && file.existsSync();

    return Stack(
      fit: StackFit.expand,
      children: [
        ColoredBox(color: p.background),
        if (hasImage)
          Image.file(
            file,
            key: ValueKey(imagePath),
            fit: BoxFit.cover,
            filterQuality: FilterQuality.medium,
            gaplessPlayback: false,
            errorBuilder: (context, error, stackTrace) =>
                const SizedBox.shrink(),
          ),
        if (hasImage)
          ColoredBox(color: p.background.withValues(alpha: scrim)),
      ],
    );
  }
}
/// Screen body wrapper — backdrop sits behind scrollable content.
class AppBackgroundBody extends ConsumerWidget {
  const AppBackgroundBody({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      fit: StackFit.expand,
      children: [
        const Positioned.fill(child: AppBackgroundBackdrop()),
        child,
      ],
    );
  }
}

/// Legacy full-screen wrapper kept for any direct use.
class AppBackground extends ConsumerWidget {
  const AppBackground({
    super.key,
    required this.child,
    this.brightness,
    this.scrimAlpha,
  });

  final Widget child;
  final Brightness? brightness;
  final double? scrimAlpha;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AppBackgroundBackdrop(scrimAlpha: scrimAlpha),
        child,
      ],
    );
  }
}
