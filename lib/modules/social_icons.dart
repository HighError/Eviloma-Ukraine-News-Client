import 'package:flutter/material.dart';

class SocialIcons {
  static var telegram = Image.asset("assets/images/icons/telegram.png");
  static var twitter = Image.asset("assets/images/icons/twitter.png");

  static Widget getIcon(String social) {
    switch (social) {
      case "telegram":
        return telegram;
      case "twitter":
        return twitter;
      default:
        return Container();
    }
  }
}
