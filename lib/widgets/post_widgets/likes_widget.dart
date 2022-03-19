import 'package:flutter/material.dart';

class LikeWidgets extends StatelessWidget {
  const LikeWidgets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.favorite_border_outlined, color: Colors.red),
        SizedBox(width: 5),
        Text("999+"),
      ],
    );
  }
}
