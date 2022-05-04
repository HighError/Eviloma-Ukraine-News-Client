import 'package:flutter/material.dart';
import 'package:news/classes/channel.dart';
import 'package:news/classes/social.dart';
import 'package:news/modules/static_data.dart';

class Post {
  final Social social;
  final Channel channel;
  final String id;
  final String message;
  final DateTime date;
  final String link;
  final List<Image> images;

  Post(
      {required this.social,
      required this.channel,
      required this.id,
      required this.message,
      required this.date,
      required this.link,
      required this.images});

  factory Post.fromJson(Map<String, dynamic> json) {
    final social = StaticData.socials.firstWhere(
      (element) => element.name == json["social"],
      orElse: () => StaticData.baseSocial,
    );

    final channel = StaticData.channels.firstWhere(
      (element) => element.id == (json["channel_id"]).toString(),
      orElse: () => StaticData.baseChannel,
    );

    List<Image> images = [];

    if (json.containsKey("images")) {
      if (json["images"] is List<dynamic>) {
        List<dynamic> _links = json["images"];
        if (_links.isNotEmpty) {
          for (var link in _links) {
            images.add(Image.network(link.toString()));
          }
        }
      }
    }

    return Post(
      social: social,
      channel: channel,
      id: json["message_id"].toString(),
      message: json["message"],
      date: DateTime.parse(json["date"]["\$date"]).toLocal(),
      link: json["url"],
      images: images,
    );
  }
}
