import 'package:flutter/material.dart';

class ScaffoldWidget {
  final AppBar appBar;
  final FloatingActionButton? floatingActionButton;

  ScaffoldWidget(this.appBar, this.floatingActionButton);
}

class ScaffoldWidgets {
  static final ScaffoldWidget channel =
      ScaffoldWidget(AppBar(title: const Text("Канали")), null);

  static final ScaffoldWidget news =
      ScaffoldWidget(AppBar(title: const Text("Новини")), null);

  static ScaffoldWidget settings(Function()? onPressed) {
    return ScaffoldWidget(
      AppBar(title: const Text("Налаштування")),
      FloatingActionButton(
        onPressed: onPressed,
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF4D77FF),
        child: const Icon(Icons.favorite),
      ),
    );
  }
}
