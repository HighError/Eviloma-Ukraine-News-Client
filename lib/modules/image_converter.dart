import 'dart:convert';

import 'package:flutter/material.dart';

class ImageConverter {
  static Image imageFromBase64String(String? base64) {
    try{
      return Image.memory(
        base64Decode(base64!),
        errorBuilder: (_, __, ___) {
          return Image.asset("assets/images/icons/placeholder.png");
        },
      );
    }
    catch (_){
      return Image.asset("assets/images/icons/placeholder.png");
    }
  }
}
