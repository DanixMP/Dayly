/// Developer contact links for the Connect with Dev screen.
class DevContact {
  const DevContact({
    required this.label,
    required this.handle,
    required this.uris,
  });

  final String label;
  final String handle;

  /// Tried in order — native app deep link first, web fallback last.
  final List<Uri> uris;

  static final github = DevContact(
    label: 'GitHub',
    handle: '@DanixMP',
    uris: [
      Uri.parse('github://github.com/DanixMP'),
      Uri.parse('https://github.com/DanixMP'),
    ],
  );

  static final instagram = DevContact(
    label: 'Instagram',
    handle: '@f.m.pourghaffar',
    uris: [
      Uri.parse('instagram://user?username=f.m.pourghaffar'),
      Uri.parse('https://www.instagram.com/f.m.pourghaffar'),
    ],
  );

  static final telegram = DevContact(
    label: 'Telegram',
    handle: '@MPHXQ',
    uris: [
      Uri.parse('tg://resolve?domain=MPHXQ'),
      Uri.parse('https://t.me/MPHXQ'),
    ],
  );

  static final email = DevContact(
    label: 'Email',
    handle: 'Mahdipur97@gmail.com',
    uris: [
      Uri(
        scheme: 'mailto',
        path: 'Mahdipur97@gmail.com',
        queryParameters: {'subject': 'Dayly feedback'},
      ),
    ],
  );

  static final all = [github, instagram, telegram, email];
}
