class Upgrade {
  static String appVersion = "Beta 0.1.2";
  final String version;
  final String link;

  Upgrade({
    required this.version,
    required this.link,
  });

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
