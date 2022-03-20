import 'package:flutter/material.dart';
import 'package:news/modules/data.dart';
import 'package:news/modules/open_link.dart';
import 'package:news/modules/update_manager.dart';
import 'package:news/modules/upgrade_messages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:upgrader/upgrader.dart';

import '../../classes/post_data.dart';
import '../../widgets/post_widgets/post_widget.dart';

RefreshController _refreshController = RefreshController(initialRefresh: false);

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget mainWidget = SizedBox(
    width: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const [
        CircularProgressIndicator(),
        SizedBox(height: 25),
        Text("Завантаження данних"),
      ],
    ),
  );

  Future<void> _update() async {
    Data.getData().then(
      (value) => setState(() {
        List<PostData> postData = [];
        for (var element in value) {
          postData.add(PostData(data: element));
          postData.sort((b, a) => a.time.compareTo(b.time));
        }
        mainWidget = ListView.builder(
          itemCount: postData.length,
          itemBuilder: (context, index) {
            return PostWidget(data: postData[index]);
          },
        );
        _refreshController.refreshCompleted();
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    _update();
  }

  @override
  Widget build(BuildContext context) {
    //Upgrader().clearSavedSettings();
    return UpgradeAlert(
      showLater: false,
      canDismissDialog: false,
      appcastConfig: UpdateManager.cfg,
      messages: MyUpgradeMessages(),
      child: SmartRefresher(
        controller: _refreshController,
        onRefresh: _update,
        child: mainWidget,
      ),
      onUpdate: () {
        OpenLink.open(
            "https://eviloma-ukraine-news.herokuapp.com/app/android", context);
        return false;
      },
    );
  }
}
