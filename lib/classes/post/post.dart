import 'package:news/classes/channel/channel.dart';
import 'package:news/classes/social/social.dart';
import 'package:news/modules/static_data.dart';

class Post {
  final Social social;
  final Channel channel;
  final String id;
  final String message;
  final DateTime date;
  final String url;

  Post(
      {required this.social,
      required this.channel,
      required this.id,
      required this.message,
      required this.date,
      required this.url});

  factory Post.fromJson(Map<String, dynamic> json) {
    final social = StaticData.socials.firstWhere(
      (element) => element.name == json["social"],
      orElse: () => StaticData.baseSocial,
    );

    final channel = StaticData.channels.firstWhere(
      (element) => element.channelId == (json["channel_id"]).toString(),
      orElse: () => StaticData.baseChannel,
    );

    return Post(
      social: social,
      channel: channel,
      id: json["message_id"].toString(),
      message: json["message"],
      date: DateTime.parse(json["date"]["\$date"]).toLocal(),
      url: json["url"],
    );
  }
}
