import 'package:flutter/material.dart';
import 'package:news/classes/upgrade/upgrade.dart';

class UpgradeWidgetAlert extends StatelessWidget {
  final bool show;
  final Upgrade? upgradeData;
  final Function()? button;

  const UpgradeWidgetAlert(
      {Key? key, required this.show, this.upgradeData, this.button})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      width: show ? double.infinity : 0,
      height: show ? double.infinity : 0,
      child: Center(
        child: AlertDialog(
          title: const Text("Оновлення додатка!"),
          content: Text(
              "Доступна нова версія додатка! Нова версія: ${upgradeData?.version ?? ""}, поточна версія: ${Upgrade.appVersion}"),
          actions: [
            TextButton(
              child: const Text("Оновити"),
              onPressed: button,
            ),
          ],
        ),
      ),
    );
  }
}
