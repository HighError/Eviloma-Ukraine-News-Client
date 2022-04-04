import 'package:flutter/material.dart';
import 'package:news/classes/social/social.dart';
import 'package:news/modules/image_converter.dart';
import 'package:news/modules/static_data.dart';

class Channel {
  final String channelId;
  final String name;
  final Social social;
  final Image avatar;
  final String link;

  Channel(
      {required this.channelId,
      required this.name,
      required this.social,
      required this.avatar,
      required this.link});

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      channelId: json['channel_id'],
      name: json['name'],
      social: StaticData.socials.firstWhere(
          (element) => element.name == json['social'],
          orElse: () => StaticData.baseSocial),
      avatar: ImageConverter.imageFromBase64String(json['avatar']),
      link: json['link'],
    );
  }
}
