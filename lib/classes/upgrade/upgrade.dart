import 'package:package_info_plus/package_info_plus.dart';

class Upgrade {
  static String? appVersion;
  final String version;
  final String link;

  Upgrade({
    required this.version,
    required this.link,
  });

  static Future<void> setAppVersionOnStart() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
  }

  bool needUpgrade() {
    return version != appVersion;
  }

  factory Upgrade.fromJson(Map<String, dynamic> json) {
    return Upgrade(
      version: json["version"],
      link: json["link"],
    );
  }
}
