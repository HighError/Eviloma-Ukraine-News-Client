import 'package:flutter/material.dart';
import 'package:news/classes/upgrade/upgrade.dart';
import 'package:news/modules/static_data.dart';
import 'package:news/widgets/upgrade_widgets/upgrade_widget.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  UpgradeWidget upgradeWidget = const UpgradeWidget(show: false);
  String log = "Пошук оновлень...";

  Future<bool> _start() async {
    await Upgrade.setAppVersionOnStart();
    var upgrade = await StaticData.loadUpgrades();
    if (upgrade.runtimeType == http.Response) {
      print(upgrade.body);
      if (upgrade.statusCode != 200) {
        setState(() {
          log = "Помилка пошуку оновлень. Перезапустіть додаток!";
        });
        return false;
      }
    }
    if (upgrade.runtimeType == Upgrade) {
      if (upgrade.needUpgrade()) {
        setState(() {
          upgradeWidget = UpgradeWidget(show: true, upgradeData: upgrade);
        });
        return false;
      }
    } else if (upgradeWidget.runtimeType != http.Response) {
      setState(() {
        log = "Невідома помилка. Перезапустіть додаток!";
      });
      return false;
    }

    setState(() {
      log = "Завантаження даних...";
    });

    var response = await StaticData.loadDataOnStart();
    if (response.statusCode != 200) {
      setState(() {
        log = "Не вдалося завантажити дані. Перезапустіть додаток!";
      });
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    _start().then((value) {
      setState(() {
        log = "Перехід до новин...";
      });
      if (value) Navigator.of(context).popAndPushNamed('/news');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 25),
                Text(log),
              ],
            ),
          ),
          upgradeWidget,
        ],
      ),
    );
  }
}
