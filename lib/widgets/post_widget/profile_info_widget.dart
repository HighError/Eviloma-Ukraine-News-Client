import 'package:flutter/material.dart';
import 'package:news/classes/post.dart';
import 'package:news/modules/open_link.dart';
import 'package:news/modules/text_style.dart';
import 'package:intl/intl.dart';

class ProfileInfoWidget extends StatelessWidget {
  final Post post;

  const ProfileInfoWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              backgroundImage: post.channel.avatar.image,
              backgroundColor: Colors.transparent,
            ),
            CircleAvatar(
              backgroundImage: post.social.icon.image,
              backgroundColor: Colors.transparent,
              radius: 10,
            ),
          ],
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.channel.name, style: TextStyles.h1),
            Text(DateFormat('dd.MM.yyyy HH:mm').format(post.date)),
          ],
        ),
      ],
    );
  }
}
