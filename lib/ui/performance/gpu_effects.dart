import 'dart:ui' show ImageFilter;

import 'package:flutter/widgets.dart';

/// GPU / Impeller capability checks for expensive UI-kit effects.
abstract final class GpuEffects {
  /// True when Impeller shader filters are available (liquid glass GPU path).
  static bool get isShaderSupported => ImageFilter.isShaderFilterSupported;

  /// Isolates an expensive effect subtree so Flutter can cache it as a layer.
  static Widget cached(Widget child, {Key? key}) =>
      RepaintBoundary(key: key, child: child);
}
