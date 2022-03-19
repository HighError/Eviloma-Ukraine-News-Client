import 'package:upgrader/upgrader.dart';

class MyUpgradeMessages extends UpgraderMessages{
  @override
  String message(UpgraderMessage messageKey){
    switch (messageKey) {
      case UpgraderMessage.body:
        return 'Доступна нова версія додатка! Нова версія: {{currentAppStoreVersion}}, поточна версія: {{currentInstalledVersion}}.';
      case UpgraderMessage.buttonTitleIgnore:
        return 'Ігнорувати';
      case UpgraderMessage.buttonTitleLater:
        return 'Пізніше';
      case UpgraderMessage.buttonTitleUpdate:
        return 'Оновити';
      case UpgraderMessage.prompt:
        return 'Будь ласка завантажте оновлення, для коректної роботи програми';
      case UpgraderMessage.title:
        return 'Оновлення додатка!';
    }
  }
}