import 'package:flutter/material.dart';
import 'package:news/screens/home_screen/home_screen.dart';

void main() {
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
      home: const BaseScreen(child: HomeScreen()),
    );
  }
}

class BaseScreen extends StatelessWidget {
  final Widget child;

  const BaseScreen({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Новини"),
        leading: GestureDetector(
          child: const Icon(Icons.menu),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Menu not working now. Please wait updates!")));
          },
        ),
      ),
      body: child,
    );
  }
}
