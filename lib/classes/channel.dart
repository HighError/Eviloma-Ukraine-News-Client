import 'package:flutter/material.dart';
import 'package:news/classes/social.dart';
import 'package:news/modules/static_data.dart';
import 'package:news/modules/version_check.dart';

class Channel {
  final String id;
  final Social social;
  final String name;
  final String link;
  final Image avatar;
  final bool support;

  Channel({
    required this.id,
    required this.social,
    required this.name,
    required this.link,
    required this.avatar,
    required this.support,
  });

  factory Channel.fromJson(Map<String, dynamic> json) {
    Image _image;
    try {
      _image = Image.network(
        json['avatar'],
        errorBuilder: (_, __, ___) {
          return Image.asset('assets/images/icons/placeholder.png');
        },
      );
    } catch (_) {
      _image = StaticData.placeholderImage;
    }

    return Channel(
      id: json['channel_id'] ?? "",
      social: StaticData.socials.firstWhere(
          (element) => element.name == json['social'],
          orElse: () => StaticData.baseSocial),
      name: json['name'],
      link: json['link'],
      avatar: _image,
      support: VersionChecker.support(json['min_version'] ?? "1.0.0"),
    );
  }
}
