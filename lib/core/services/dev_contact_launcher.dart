import 'package:url_launcher/url_launcher.dart';

import '../../features/settings/dev_contact.dart';

/// Opens developer contact links in the native app when available.
class DevContactLauncher {
  const DevContactLauncher._();

  static Future<bool> open(DevContact contact) async {
    for (final uri in contact.uris) {
      if (_isNativeScheme(uri.scheme)) {
        if (await _tryLaunch(uri, LaunchMode.externalApplication)) {
          return true;
        }
      }
    }

    for (final uri in contact.uris) {
      if (uri.scheme == 'https') {
        if (await _tryLaunch(uri, LaunchMode.externalNonBrowserApplication)) {
          return true;
        }
      }
    }

    for (final uri in contact.uris) {
      if (uri.scheme == 'mailto' || uri.scheme == 'https') {
        if (await _tryLaunch(uri, LaunchMode.externalApplication)) {
          return true;
        }
      }
    }

    return false;
  }

  static bool _isNativeScheme(String scheme) {
    return scheme != 'https' && scheme != 'http' && scheme != 'mailto';
  }

  static Future<bool> _tryLaunch(Uri uri, LaunchMode mode) async {
    try {
      return await launchUrl(uri, mode: mode);
    } on Exception {
      return false;
    }
  }
}
