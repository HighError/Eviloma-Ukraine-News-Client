import 'package:flutter/material.dart';

class Social {
  final String name;
  final Image icon;

  Social(this.name, this.icon);

  factory Social.fromJson(Map<String, dynamic> json) {
    return Social(
      json["name"],
      Image.asset(
        "assets/images/icons/${json['name']}.png",
        errorBuilder: (_, __, ___) {
          return Image.asset("assets/images/icons/placeholder.png");
        },
      ),
    );
  }
}
