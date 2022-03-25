import 'dart:convert';
import 'package:news/classes/channel/channel.dart';
import 'package:news/classes/post/post.dart';
import 'package:news/classes/social/social.dart';
import 'package:http/http.dart' as http;
import 'package:news/classes/upgrade/upgrade.dart';

class StaticData {
  static final Social baseSocial = Social.fromJson({"name": "other"});
  static final Channel baseChannel =
      Channel.fromJson({"channel_id": "", "name": "Other", "link": ""});

  static List<Social> socials = [];
  static List<Channel> channels = [];
  static List<Post> posts = [];

  static Future<http.Response> loadDataOnStart() async {
    http.Response response = await loadSocials();
    if (response.statusCode != 200) {
      return response;
    }

    response = await loadChannels();
    if (response.statusCode != 200) {
      return response;
    }

    response = await loadPosts();
    if (response.statusCode != 200) {
      return response;
    }

    return http.Response("", 200);
  }

  static Future<http.Response> loadSocials() async {
    final response = await http
        .get(Uri.parse("http://api.news.eviloma.xyz/get/socials"))
        .catchError((e) {
      return http.Response(e.toString(), 500);
    }).timeout(const Duration(seconds: 10), onTimeout: () {
      return http.Response('Timeout', 408);
    });

    if (response.statusCode != 200) {
      return http.Response(response.body, response.statusCode);
    }
    Iterable i = json.decode(response.body);
    socials = List<Social>.from(i.map((e) => Social.fromJson(e)));
    return http.Response("", 200);
  }

  static Future<http.Response> loadChannels() async {
    final response = await http
        .get(Uri.parse("http://api.news.eviloma.xyz/get/channels"))
        .catchError((e) {
      return http.Response(e.toString(), 500);
    }).timeout(const Duration(seconds: 10), onTimeout: () {
      return http.Response('Timeout', 408);
    });

    if (response.statusCode != 200) {
      return http.Response(response.body, response.statusCode);
    }
    Iterable i = json.decode(response.body);
    channels = List<Channel>.from(i.map((e) => Channel.fromJson(e)));
    return http.Response("", 200);
  }

  static Future<http.Response> loadPosts() async {
    final response = await http
        .get(Uri.parse("http://api.news.eviloma.xyz/get/posts"))
        .catchError((e) {
      return http.Response(e.toString(), 500);
    }).timeout(const Duration(seconds: 10), onTimeout: () {
      return http.Response('Timeout', 408);
    });

    if (response.statusCode != 200) {
      return http.Response(response.body, response.statusCode);
    }
    Iterable i = json.decode(response.body);
    posts = List<Post>.from(i.map((e) => Post.fromJson(e)));
    posts.sort((b, a) => a.date.compareTo(b.date));
    return http.Response("", 200);
  }

  static Future<dynamic> loadUpgrades() async {
    final response = await http
        .get(Uri.parse("http://api.news.eviloma.xyz/app/apk"))
        .catchError((e) {
      return http.Response(e.toString(), 500);
    }).timeout(const Duration(seconds: 10), onTimeout: () {
      return http.Response('Timeout', 408);
    });

    if (response.statusCode != 200) {
      return http.Response(response.body, response.statusCode);
    }
    return Upgrade.fromJson(json.decode(response.body));
  }
}