import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenLink {
  static void open(String url, BuildContext context) async {
    try {
      await launchUrl(Uri.parse(url));
    } catch (_) {}
  }
}
