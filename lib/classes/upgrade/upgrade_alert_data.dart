import 'package:flutter/material.dart';

class UpgradeAlertData{
  String message = "";
  Color circleBarColor = Colors.green;
  double progress = 0;
  bool showProgressText = false;
  Function()? buttonFunction;
}