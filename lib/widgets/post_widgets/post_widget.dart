import 'package:flutter/material.dart';
import 'package:news/classes/post_data.dart';
import 'package:news/modules/open_link.dart';
import 'package:news/widgets/post_widgets/profile_info_widget.dart';

class PostWidget extends StatelessWidget {
  final PostData data;

  const PostWidget({Key? key, required this.data}) : super(key: key);

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
              ProfileInfoWidget(data: data),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Divider(color: Colors.white),
              ),
              Text(data.post),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      OpenLink.open(data.url, context);
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
