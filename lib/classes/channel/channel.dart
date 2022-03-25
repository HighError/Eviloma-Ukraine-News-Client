import 'package:flutter/material.dart';
import 'package:news/modules/image_converter.dart';

class Channel {
  final String channelId;
  final String name;
  final Image avatar;
  final String link;

  Channel(
      {required this.channelId,
      required this.name,
      required this.avatar,
      required this.link});

  factory Channel.fromJson(Map<String, dynamic> json) {
    return Channel(
      channelId: json['channel_id'],
      name: json['name'],
      avatar: ImageConverter.imageFromBase64String(json['avatar']),
      link: json['link'],
    );
  }
}
