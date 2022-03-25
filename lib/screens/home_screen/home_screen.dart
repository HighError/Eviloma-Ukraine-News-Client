import 'package:flutter/material.dart';
import 'package:news/modules/static_data.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../widgets/post_widgets/post_widget.dart';

RefreshController _refreshController = RefreshController(initialRefresh: false);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> _update() async {
    await StaticData.loadPosts().then((value) {
      setState(() {
        if (value.statusCode == 200) {
          _refreshController.refreshCompleted();
        } else {
          _refreshController.refreshFailed();
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _update,
      //child: mainWidget,
      child: SizedBox(
        width: double.infinity,
        child: ListView.builder(
          itemCount: StaticData.posts.length,
          itemBuilder: (context, index) {
            return PostWidget(post: StaticData.posts[index]);
          },
        ),
      ),
    );
  }
}
