import 'package:permission_handler/permission_handler.dart';

import '../platform.dart';

/// Runtime permission requests (Design.MD §8). Only meaningful on mobile;
/// returns `false` elsewhere so callers can short-circuit the camera flow.
class PermissionService {
  /// Camera + microphone, required before opening the recorder.
  static Future<bool> requestCameraAndMic() async {
    if (!isMobilePlatform) return false;
    final statuses = await [Permission.camera, Permission.microphone].request();
    return statuses.values.every((s) => s.isGranted);
  }
}
