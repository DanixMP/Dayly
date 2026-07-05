import 'package:flutter/foundation.dart';

/// Capability flags used to gate device-only features (camera, FFmpeg merge,
/// gallery export, notifications) without importing `dart:io` — keeps the
/// checks usable from widget code and avoids hard platform coupling.

/// True on Android/iOS, where the camera + FFmpeg + gallery pipeline runs.
bool get isMobilePlatform =>
    !kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS);
