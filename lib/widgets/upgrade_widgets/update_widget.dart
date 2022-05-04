import 'package:flutter/material.dart';
import 'package:news/classes/upgrade_alert_data.dart';

class UpdateWidget extends StatelessWidget {
  final UpdateDownloadData data;

  const UpdateWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: AlertDialog(
          title: const Text("Завантаження оновлення"),
          content: Row(
            children: [
              CircularProgressIndicator(
                value: data.progress,
                color: data.circleBarColor,
              ),
              const SizedBox(width: 20),
              Flexible(child: Text(data.message)),
            ],
          ),
        ),
      ),
    );
  }
}
