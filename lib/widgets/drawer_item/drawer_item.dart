import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String route;
  const DrawerItem({Key? key, required this.title, required this.icon, required this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.of(context).popAndPushNamed(route);
      },
    );
  }
}
