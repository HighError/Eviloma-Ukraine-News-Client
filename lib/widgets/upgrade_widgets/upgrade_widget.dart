import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news/classes/upgrade/upgrade.dart';
import 'package:news/classes/upgrade/upgrade_alert_data.dart';
import 'package:news/modules/open_link.dart';
import 'package:news/widgets/upgrade_widgets/upgrade_widget_alert.dart';
import 'package:news/widgets/upgrade_widgets/upgrade_widget_download.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class UpgradeWidget extends StatefulWidget {
  final bool show;
  final Upgrade? upgradeData;

  const UpgradeWidget({Key? key, required this.show, this.upgradeData})
      : super(key: key);

  @override
  State<UpgradeWidget> createState() => _UpgradeWidgetState();
}

class _UpgradeWidgetState extends State<UpgradeWidget> {
  bool upgradeState = false;
  UpgradeAlertData upgradeAlertData = UpgradeAlertData();

  void updateAlert(
      {String? message,
      Color? color,
      double? progress,
      bool? showProgress,
      Function()? button}) {
    setState(() {
      if (message != null) upgradeAlertData.message = message;
      if (color != null) upgradeAlertData.circleBarColor = color;
      if (progress != null) upgradeAlertData.progress = progress;
      if (showProgress != null) {
        upgradeAlertData.showProgressText = showProgress;
      }
      upgradeAlertData.buttonFunction = button;
    });
  }

  Future<void> upgrade(String link) async {
    setState(() {
      upgradeState = true;
    });
    updateAlert(message: "Запит дозволу на завантаження");

    if (await Permission.storage.request().isGranted) {
      updateAlert(message: "Підготовка до завантаження...");

      final tempPath = await getTemporaryDirectory();
      try {
        await Dio().download(
          link,
          '${tempPath.path}/app.apk',
          onReceiveProgress: (int sent, int total) {
            updateAlert(
              message: "Завантаження оновлення...",
              showProgress: true,
              color: Colors.green,
              progress: (sent / total),
            );
          },
        );

        updateAlert(
          message: "Встановлення...",
          showProgress: false,
          color: Colors.green,
          progress: 1,
        );

        OpenFile.open("${tempPath.path}/app.apk");
      } catch (e) {
        updateAlert(
          message:
              "Помилка завантаження! Перезапустіть додаток та спробуйте ще раз, або завантажте оновлення натиснувши на кнопку 'Завантажити'",
          showProgress: false,
          color: Colors.red,
          progress: 1,
          button: () {
            OpenLink.open(link == "" ? "https://news.eviloma.xyz/" : link , context);
          },
        );
      }
    } else {
      updateAlert(
        message:
            "Дозвіл не видано! Автоонвлення додатка неможливе. Натисніть 'Завантажити' для відкриття браузера",
        showProgress: false,
        color: Colors.red,
        progress: 1,
        button: () {
          OpenLink.open(link == "" ? "https://news.eviloma.xyz/" : link , context);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (upgradeState) {
      return UpgradeWidgetDownload(upgradeAlertData: upgradeAlertData);
    } else {
      return UpgradeWidgetAlert(
        show: widget.show,
        upgradeData: widget.upgradeData,
        button: () {
          upgrade(widget.upgradeData?.link ?? "");
        },
      );
    }
  }
}
