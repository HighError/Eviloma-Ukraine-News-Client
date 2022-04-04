import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:news/classes/channel/channel.dart';
import 'package:news/modules/static_data.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

import '../../classes/social/social.dart';

class ChannelListScreen extends StatelessWidget {
  const ChannelListScreen({Key? key}) : super(key: key);

  List<Widget> getChannels() {
    List<Widget> widgets = [];
    if (StaticData.socials.isNotEmpty) {
      for (var item in StaticData.socials) {
        List<Channel> channels = StaticData.channels
            .where((element) => element.social == item)
            .toList();
        widgets.add(
          SliverStickyHeader.builder(
            builder: (_, state) => Container(
              height: 60,
              color: Colors.lightBlue.withOpacity(1.0 - state.scrollPercentage),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.centerLeft,
              child: Text(toBeginningOfSentenceCase(item.name) ?? ""),
            ),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundImage: channels[index].avatar.image,
                    backgroundColor: Colors.transparent,
                  ),
                  title: Text(channels[index].name),
                ),
                childCount: channels.length,
              ),
            ),
          ),
        );
      }
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: getChannels());
  }
}
