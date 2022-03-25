import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import '../../classes/social/social.dart';

class ChannelListScreen extends StatelessWidget {
  const ChannelListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Social telegram = Social.fromJson({"name": "telegram"});

    return CustomScrollView(
      slivers: [
        SliverStickyHeader(
          header: const _Header(title: "Telegram"),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
              ],
            ),
          ),
        ),
        SliverStickyHeader(
          header: const _Header(title: "Twitter"),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [

              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final String title;

  const _Header({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      color: Colors.blue,
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontFamily: "Raleway",
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}
