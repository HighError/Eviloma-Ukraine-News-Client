import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:news/modules/static_data.dart';
import '../../widgets/post_widgets/post_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final EasyRefreshController _controller = EasyRefreshController();

  Future<void> _update() async {
    await StaticData.loadPosts().then((value) {
      setState(() {
        if (value.statusCode == 200) {
          _controller.finishLoadCallBack;
        } else {
          _controller.resetRefreshStateCallBack;
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: EasyRefresh(
        header: MaterialHeader(),
        controller: _controller,
        child: ListView.builder(
          itemCount: StaticData.posts.length,
          itemBuilder: (context, index) {
            return PostWidget(post: StaticData.posts[index]);
          },
        ),
        onRefresh: _update,
      ),
    );
  }
}
