import 'package:flutter/material.dart';
import 'package:news/modules/static_data.dart';
import 'package:news/widgets/channel_widget/channel_widget.dart';

class ChannelsScreen extends StatefulWidget {
  const ChannelsScreen({Key? key}) : super(key: key);

  @override
  State<ChannelsScreen> createState() => _ChannelsScreenState();
}

class _ChannelsScreenState extends State<ChannelsScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: StaticData.channels.length,
        itemBuilder: (BuildContext context, int index) {
          return ChannelWidget(channel: StaticData.channels[index]);
        },
      ),
    );
  }
}
