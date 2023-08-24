import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

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

  void addRecentlyViewed(appName, dynamic productId) async {
    FlutterSecureStorage storage = const FlutterSecureStorage();
    var valueString = await storage.read(key: '$appName-viewed') ?? '[]';

    List<dynamic> valueList;
    valueList = json.decode(valueString);

    if (valueList.where((element) => element == productId).isNotEmpty) return;
    if (valueList.length >= 20) {
      valueList.removeAt(19);
    }
    valueList.insert(0, productId);
    print('저장: ${valueList}');
    storage.write(key: '$appName-viewed', value: jsonEncode(valueList));
  }
}
