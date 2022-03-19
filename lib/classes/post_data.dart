import 'package:flutter/material.dart';
import 'package:news/classes/post.dart';
import 'package:news/modules/social_icons.dart';

class PostData{
  ImageProvider avatarWidget = AssetImage("assets/images/icons/telegram.png");
  Widget socialIconWidget = SocialIcons.getIcon("telegram");
  String username = "";
  DateTime time = DateTime.now();
  String post = "";
  String url = "";

  PostData({required Post data}){
    avatarWidget = AssetImage("assets/images/avatars/${data.social}/${data.username}.jpg");
    socialIconWidget = SocialIcons.getIcon(data.social);
    username = data.username;
    time = data.date;
    post = data.message;
    url = data.url;
  }
}