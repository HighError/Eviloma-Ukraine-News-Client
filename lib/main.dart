import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news/classes/upgrade.dart';
import 'package:news/classes/upgrade_alert_data.dart';
import 'package:news/modules/open_link.dart';
import 'package:news/modules/static_data.dart';
import 'package:news/modules/text_style.dart';
import 'package:news/screens/channels_screen/channels_screen.dart';
import 'package:news/screens/news_screen/news_screen.dart';
import 'package:news/screens/settings_screen/settings_screen.dart';
import 'package:news/widgets/scaffold_widget/scaffold_widget.dart';
import 'package:news/widgets/upgrade_widgets/update_widget.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

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
        // '/': (context) => const LoadingScreen(),
        // '/news': (context) => const BaseScreen(child: HomeScreen()),
        // '/channels': (context) => const BaseScreen(child: ChannelListScreen()),
        '/': (context) => const BaseScreen(),
      },
      //home: const BaseScreen(child: HomeScreen()),
    );
  }
}

class BaseScreen extends StatefulWidget {
  const BaseScreen({Key? key}) : super(key: key);

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  int _selectedIndex = 1;
  Widget _child = const NewsScreen();
  AppBar _appBar = ScaffoldWidgets.news.appBar;
  Widget? _floatingButton;
  bool _showScaffoldContent = true;

  void _showSupportDialog() {
    setState(() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.favorite,
                      color: Color(0xFF4D77FF), size: 40),
                  const SizedBox(height: 10),
                  Text("Підтримка", style: TextStyles.h1),
                  const SizedBox(height: 20),
                  const Text(
                    "Цей додаток розробляється українцями для українців. Ми не додаємо рекламу, щоб не бісити Вас. На томість ви можете підтримати нас матеріально на ko-fi.com",
                    style: TextStyle(color: Color(0xAAFFFFFF)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("СКАСУВАТИ",
                              style: TextStyle(fontSize: 18))),
                      TextButton(
                          onPressed: () {
                            OpenLink.open(
                                "https://ko-fi.com/higherror", context);
                          },
                          child: const Text("ПІДТРИМАТИ",
                              style: TextStyle(fontSize: 18))),
                    ],
                  )
                ],
              ),
            );
          });
    });
  }

  Future<void> _checkUpdate() async {
    var response = await StaticData.checkUpdates();
    if (response.statusCode != 200) {
      return;
    } else if (StaticData.upgrade!.needUpgrade()) {
      setState(
        () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Оновлення"),
                content: Text(
                    "Доступна нова версія додатка: ${StaticData.upgrade!.version}.\nВаша версія: ${Upgrade.appVersion}.\nБажаєте оновити додаток?"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Пропустити")),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        _update();
                      },
                      child: const Text("Завантажити"))
                ],
              );
            },
          );
        },
      );
    }
  }

  Future<void> _update() async {
    UpdateDownloadData _data = UpdateDownloadData();
    _data.message = "Підготовка до завантаження...";
    _data.circleBarColor = Colors.green;
    _data.progress = 0;
    setState(
      () {
        _child = UpdateWidget(data: _data);
        _showScaffoldContent = false;
      },
    );

    if (await Permission.storage.request().isGranted) {
      final tempPath = await getTemporaryDirectory();
      try {
        await Dio().download(
          StaticData.upgrade!.link,
          '${tempPath.path}/app.apk',
          onReceiveProgress: (int sent, int total) {
            setState(() {
              _data.progress = sent / total;
              _data.message =
                  "Завантаження: ${(_data.progress * 100).round()}%";
              _child = UpdateWidget(data: _data);
            });
          },
        );

        setState(() {
          _data.progress = 1;
          _data.circleBarColor = Colors.green;
          _data.message = "Встановлення...";
          _child = UpdateWidget(data: _data);
        });

        OpenFile.open("${tempPath.path}/app.apk");
      } catch (e) {
        setState(() {
          _data.progress = 1;
          _data.circleBarColor = Colors.red;
          _data.message =
              "Помилка оновлення додатку. Спробуйте пізніше або завантажте оновлення вручну на нашому вебсайті.";
          _child = UpdateWidget(data: _data);
        });
      }
    } else {
      setState(() {
        _data.message =
            "Дозвіл не видано! Автоонвлення додатка неможливе. Завантажте оновлення вручну на нашому вебсайті.";
        _data.circleBarColor = Colors.red;
        _data.progress = 1;
        _child = UpdateWidget(data: _data);
      });
    }
  }

  void _changeScreen(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        _child = const ChannelsScreen();
        _appBar = ScaffoldWidgets.channel.appBar;
        _floatingButton = ScaffoldWidgets.channel.floatingActionButton;
      } else if (index == 1) {
        _child = const NewsScreen();
        _appBar = ScaffoldWidgets.news.appBar;
        _floatingButton = ScaffoldWidgets.news.floatingActionButton;
      } else if (index == 2) {
        _child = const SettingsScreen();
        var _widget = ScaffoldWidgets.settings(_showSupportDialog);
        _appBar = _widget.appBar;
        _floatingButton = _widget.floatingActionButton;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _checkUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: !_showScaffoldContent ? null : _appBar,
      body: _child,
      floatingActionButton: _floatingButton,
      bottomNavigationBar: !_showScaffoldContent
          ? null
          : BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.supervised_user_circle), label: "Канали"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.newspaper), label: "Новини"),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: "Налаштування")
              ],
              selectedIconTheme: const IconThemeData(color: Color(0xFF4D77FF)),
              fixedColor: const Color(0xFF4D77FF),
              currentIndex: _selectedIndex,
              onTap: (index) {
                _changeScreen(index);
              },
            ),
    );
  }
}
