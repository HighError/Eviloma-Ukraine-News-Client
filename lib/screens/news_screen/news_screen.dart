import 'package:flutter/material.dart';
import 'package:news/modules/static_data.dart';
import 'package:news/widgets/post_widget/post_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final RefreshController _refreshController = RefreshController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      if (!StaticData.firstUpdateData) {
        _refreshController.requestRefresh();
        StaticData.firstUpdateData = true;
      }
    });
  }

  Future<void> _update() async {
    var response = await StaticData.loadChannels();
    if (response.statusCode != 200) {
      if (!mounted) return;
      setState(() {
        _refreshController.refreshFailed();
      });
      return;
    }

    response = await StaticData.loadPosts();
    if (!mounted) return;
    if (response.statusCode != 200) {
      setState(() {
        _refreshController.refreshFailed();
      });
      return;
    }

    if (!mounted) return;
    setState(() {
      StaticData.firstUpdateData = true;
      _refreshController.refreshCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      child: SmartRefresher(
        controller: _refreshController,
        onRefresh: _update,
        child: ListView.builder(
          itemCount: StaticData.posts.length,
          itemBuilder: (BuildContext context, int index) {
            return PostWidget(post: StaticData.posts[index]);
          },
        ),
      ),
    );
  }
}
