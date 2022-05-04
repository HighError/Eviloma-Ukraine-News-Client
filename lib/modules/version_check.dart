import 'package:news/classes/upgrade.dart';

class VersionChecker {
  static bool support(String version) {
    if (version == "") return false;
    List<int> client =
        Upgrade.appVersion.split(".").map((e) => int.parse(e)).toList();
    List<int> server = version.split(".").map((e) => int.parse(e)).toList();

    if (client.length != 3) return false;
    if (server.length != 3) return false;

    for (int i = 0; i < 3; i++) {
      if (client[i] > server[i]) return true;
      if (client[i] < server[i]) return false;
    }
    return true;
  }
}
