import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:news/classes/channel.dart';
import 'package:news/classes/post.dart';
import 'package:news/classes/social.dart';
import 'package:http/http.dart' as http;
import 'package:news/classes/upgrade.dart';

class StaticData {
  static bool firstUpdateData = false;
  static final Image placeholderImage =
      Image.asset('assets/images/icons/placeholder.png');
  //static const String _baseUrl = "http://10.0.2.2:5000/";
  static const String _baseUrl = "https://api.news.eviloma.xyz/";
  static final Social baseSocial = Social("Other", placeholderImage);
  static final Channel baseChannel = Channel(
      id: "0",
      social: baseSocial,
      name: "Other",
      link: "",
      avatar: placeholderImage,
      support: true);
  static Upgrade? upgrade;

  static final List<Social> socials = [
    Social("Twitter", Image.asset('assets/images/icons/twitter.png')),
    Social("Telegram", Image.asset('assets/images/icons/telegram.png')),
    Social("Facebook", Image.asset('assets/images/icons/facebook.png')),
  ];

  static List<Channel> channels = [];
  static List<Post> posts = [];

  static Future<http.Response> loadChannels() async {
    final Uri url = Uri.parse(_baseUrl + 'get/channels');
    final response = await http.get(url).catchError((e) {
      return http.Response(e.toString(), 500);
    }).timeout(const Duration(seconds: 60), onTimeout: () {
      return http.Response("Timeout: $url", 408);
    }).onError((error, stackTrace) => http.Response("Client error!", 500));

    if (response.statusCode != 200) {
      return http.Response(response.body, response.statusCode);
    }

    Iterable i = json.decode(response.body);
    channels = List<Channel>.from(i.map((e) => Channel.fromJson(e)));
    return http.Response("", 200);
  }

  static Future<http.Response> loadPosts() async {
    final Uri url = Uri.parse(_baseUrl + 'get/posts');

    final response = await http.get(url).catchError((e) {
      return http.Response(e.toString(), 500);
    }).timeout(const Duration(seconds: 60), onTimeout: () {
      return http.Response("Timeout: $url", 408);
    }).onError((error, stackTrace) => http.Response("Client error!", 500));
    if (response.statusCode != 200) {
      return http.Response(response.body, response.statusCode);
    }

    Iterable i = json.decode(response.body);
    posts = List<Post>.from(i.map((e) => Post.fromJson(e)));
    posts.sort((a, b) => b.date.compareTo(a.date));
    return http.Response("", 200);
  }

  static Future<http.Response> checkUpdates() async {
    final Uri url = Uri.parse(_baseUrl + 'app/apk');

    final response = await http.get(url).catchError((e) {
      return http.Response(e.toString(), 500);
    }).timeout(const Duration(seconds: 60), onTimeout: () {
      return http.Response("Timeout: $url", 408);
    }).onError((error, stackTrace) => http.Response("Client error!", 500));
    if (response.statusCode == 200) {
      upgrade = Upgrade.fromJson(json.decode(response.body));
      return http.Response("", 200);
    }

    return http.Response(response.body, response.statusCode);
  }
}
