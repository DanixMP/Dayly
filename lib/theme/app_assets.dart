import 'package:flutter/widgets.dart';

/// Bundled image assets.
class AppAssets {
  const AppAssets._();

  static const logo = 'assets/logo.png';
}

/// Dayly app mark from [AppAssets.logo].
class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.size = 88,
    this.borderRadius,
    this.circular = false,
  });

  final double size;
  final double? borderRadius;

  /// When true, clips the logo to a circle (used on splash inside the heart).
  final bool circular;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      AppAssets.logo,
      width: size,
      height: size,
      fit: BoxFit.cover,
      filterQuality: FilterQuality.high,
    );

    if (circular) {
      return ClipOval(
        child: SizedBox(width: size, height: size, child: image),
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? size * 0.22),
      child: image,
    );
  }
}
