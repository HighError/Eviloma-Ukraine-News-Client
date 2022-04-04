import 'package:flutter/material.dart';
import 'package:news/classes/upgrade/upgrade.dart';
import 'package:news/screens/channel_list_screen/channel_list_screen.dart';
import 'package:news/screens/home_screen/home_screen.dart';
import 'package:news/screens/loading_screen/loading_screen.dart';
import 'package:news/widgets/drawer_item/drawer_item.dart';

import 'modules/static_data.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        fontFamily: "Raleway",
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoadingScreen(),
        '/news': (context) => const BaseScreen(child: HomeScreen()),
        '/channels': (context) => const BaseScreen(child: ChannelListScreen())
      },
      //home: const BaseScreen(child: HomeScreen()),
    );
  }
}

class BaseScreen extends StatefulWidget {
  final Widget child;

  const BaseScreen({Key? key, required this.child}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Новини"),
      ),
      body: widget.child,
      drawer: Drawer(
        child: ListView(
          children: const [
            DrawerItem(title: "Новини", icon: Icons.newspaper, route: "/news"),
            DrawerItem(title: "Канали", icon: Icons.people, route: "/channels"),
          ],
        ),
      ),
    );
  }
}
