import 'package:upgrader/upgrader.dart';

class UpdateManager {
  static const appcastURL = "https://eviloma-ukraine-news.herokuapp.com/app";
  static final cfg = AppcastConfiguration(
    url: appcastURL,
    supportedOS: ['android']
  );
}