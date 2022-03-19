import 'package:flutter/material.dart';
import 'package:news/classes/post_data.dart';
import 'package:news/modules/text_style.dart';
import 'package:intl/intl.dart';

class ProfileInfoWidget extends StatelessWidget {
  final PostData data;

  const ProfileInfoWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              backgroundImage: data.avatarWidget,
            ),
            CircleAvatar(
              child: data.socialIconWidget,
              radius: 10,
            ),
          ],
        ),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(data.username, style: TextStyles.h1),
            Text(DateFormat('dd.MM.yyyy kk:mm').format(data.time)),
          ],
        )
      ],
    );
  }
}
