import 'package:flutter/material.dart';
import 'package:news/classes/channel.dart';
import 'package:news/modules/open_link.dart';

class ChannelWidget extends StatefulWidget {
  final Channel channel;
  const ChannelWidget({Key? key, required this.channel}) : super(key: key);

  @override
  State<ChannelWidget> createState() => _ChannelWidgetState();
}

class _ChannelWidgetState extends State<ChannelWidget> {
  bool _enable = true;

  @override
  Widget build(BuildContext context) {
    Widget _icon = Container();

    if (!widget.channel.support) {
      _icon = IconButton(
          onPressed: () {
            setState(
              () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(widget.channel.name),
                      content: const Text(
                        "Ця версія не підтримує цей канал. Будь ласка оновіть додаток",
                        style: TextStyle(color: Color(0x99FFFFFF)),
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("OK"))
                      ],
                    );
                  },
                );
              },
            );
          },
          icon: _ChannelWidgetIcons.warning);
    } else if (!_enable) {
      _icon = IconButton(
          onPressed: () {
            setState(() {
              _enable = true;
            });
          },
          icon: _ChannelWidgetIcons.disable);
    } else {
      _icon = IconButton(
          onPressed: () {
            setState(() {
              _enable = false;
            });
          },
          icon: _ChannelWidgetIcons.enable);
    }

    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              OpenLink.open(widget.channel.link, context);
            },
            child: Row(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage: widget.channel.avatar.image,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: widget.channel.social.icon.image,
                      radius: 10,
                    )
                  ],
                ),
                const SizedBox(width: 15),
                Text(
                  widget.channel.name,
                  style: const TextStyle(fontSize: 20),
                )
              ],
            ),
          ),
          // _icon,
        ],
      ),
    );
  }
}

class _ChannelWidgetIcons {
  static const Icon enable = Icon(Icons.visibility);
  static const Icon disable = Icon(Icons.visibility_off);
  static const Icon warning = Icon(Icons.warning, color: Colors.orange);
}
