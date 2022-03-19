import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenLink{
  static void open(String url, BuildContext context) async{
    if (!await launch(url)){
      print("Error open $url");
    }
  }
}