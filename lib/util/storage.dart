import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_core2/model/notification.dart';

class Storage {
  void initStorage() async {
    // 앱 삭제 후 처음 앱을 실행하면 데이터 제거
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('first_run') ?? true) {
      FlutterSecureStorage storage = const FlutterSecureStorage();
      await storage.deleteAll();
      prefs.setBool('first_run', false);
    }
  }

  void addRecentlyViewed(String key, dynamic productId) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    var valueString = await storage.read(key: key) ?? '[]';

    List<dynamic> valueList;
    valueList = json.decode(valueString);

    if (valueList.where((element) => element == productId).isNotEmpty) return;
    if (valueList.length >= 30) {
      valueList.removeAt(29);
    }
    valueList.insert(0, productId);
    storage.write(key: key, value: jsonEncode(valueList));
  }

  void addNotification(String key, CustomerNotification notification) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    var notiString = await storage.read(key: key) ?? '[]';

    List<CustomerNotification> notiList;
    notiList = notificationFromJson(notiString);

    if (notiList.length >= 30) {
      notiList.removeAt(29);
    }
    notiList.insert(0, notification);
    storage.write(key: key, value: jsonEncode(notiList));
  }
}
