import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image_null_safe/full_screen_image_null_safe.dart';
import 'package:news/classes/post.dart';
import 'package:news/modules/open_link.dart';
import 'package:news/widgets/post_widget/profile_info_widget.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget _images = Container();
    if (post.images.isNotEmpty) {
      int _counter = 0;
      _images = CarouselSlider(
        options: CarouselOptions(),
        items: post.images.map((i) {
          return Builder(
            builder: (BuildContext context) {
              _counter++;
              return FullScreenWidget(
                child: Hero(
                  tag: "${post.id} - $_counter",
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: i,
                  ),
                ),
              );
            },
          );
        }).toList(),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileInfoWidget(post: post),
                  IconButton(
                    onPressed: () {
                      OpenLink.open(post.link, context);
                    },
                    icon: const Icon(
                      Icons.newspaper,
                      color: Color(0xFF4D77FF),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5),
                child: Divider(color: Colors.white),
              ),
              _images,
              SizedBox(
                width: double.infinity,
                child: Text(post.message),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
