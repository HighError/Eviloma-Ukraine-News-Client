import 'dart:convert';

import 'package:http/http.dart' as http;

import '../classes/post.dart';

class Data{
  static Future<List<Post>> getData() async{
    final response = await http.get(Uri.parse(
        "https://eviloma-ukraine-news.herokuapp.com/data"));
    if (response.statusCode == 200){
      Iterable i = json.decode(response.body);
      List<Post> posts = List<Post>.from(i.map((e) => Post.fromJson(e)));
      return posts;
    }
    else{
      return [];
    }
  }
}