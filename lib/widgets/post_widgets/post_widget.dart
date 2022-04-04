import 'package:flutter/material.dart';
import 'package:news/classes/post/post.dart';
import 'package:news/modules/open_link.dart';
import 'package:news/widgets/post_widgets/profile_info_widget.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ProfileInfoWidget(post: post),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Divider(color: Colors.white),
              ),
              SizedBox(
                width: double.infinity,
                child: Text(post.message),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      OpenLink.open(post.url, context);
                    },
                    icon: const Icon(Icons.chevron_right),
                    label: const Text("Джерело"),
                    style: const ButtonStyle(),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
