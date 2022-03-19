class Post {
  final String social;
  final int channelId;
  final int messageId;
  final String username;
  final String message;
  final DateTime date;
  final String url;

  Post(
      {required this.social,
      required this.channelId,
      required this.messageId,
      required this.username,
      required this.message,
      required this.date,
      required this.url});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        social: json["social"],
        channelId: json["channelId"],
        messageId: json["messageId"],
        username: json["username"],
        message: json["message"],
        date: DateTime.parse(json["date"]["\$date"]).toLocal(),
        url: json["url"]);
  }
}
