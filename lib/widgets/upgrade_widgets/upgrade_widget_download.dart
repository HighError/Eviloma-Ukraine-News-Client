import 'package:flutter/material.dart';
import 'package:news/classes/upgrade/upgrade_alert_data.dart';

class UpgradeWidgetDownload extends StatelessWidget {
  final UpgradeAlertData upgradeAlertData;
  const UpgradeWidgetDownload({Key? key, required this.upgradeAlertData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: AlertDialog(
          title: const Text("Оновлення ..."),
          content: Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: upgradeAlertData.progress,
                    color: upgradeAlertData.circleBarColor,
                  ),
                  Text(
                    upgradeAlertData.showProgressText
                        ? "${(upgradeAlertData.progress * 100).round()}%"
                        : "",
                    style: const TextStyle(fontSize: 12),
                    softWrap: false,
                    maxLines: 10,
                  ),
                ],
              ),
              const SizedBox(width: 20),
              Flexible(child: Text(upgradeAlertData.message)),
            ],
          ),
          actions: [
            TextButton(
              child: const Text("Завантажити"),
              onPressed: upgradeAlertData.buttonFunction,
            ),
          ],
        ),
      ),
    );
  }
}
