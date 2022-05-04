class Upgrade {
  static const String appVersion = "1.0.0";
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
