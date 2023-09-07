import 'dart:convert';
import 'package:http/http.dart' as http;

class HolidayService {
  static Future<List<dynamic>?> getHolidays(solYear, solMonth) async {
    try {
      var response = await http.get(
        Uri.parse(
            'https://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getHoliDeInfo?solYear=$solYear&solMonth=$solMonth&ServiceKey=AHdz%2FUMTFcwVNKFNx7KF4cMpFN%2Bp6aQjyID1CsGYOQJI4V0T2R4Sh2wLbzHxlBnp3BYTjNYx8QLrxfs4jLWuaA%3D%3D&_type=json'),
      );
      if (response.statusCode == 200) {
        if (jsonDecode(response.body)['response']['body']['items']['item']
                .runtimeType ==
            List) {
          return jsonDecode(response.body)['response']['body']['items']['item']
              .map((e) => e['locdate'])
              .toList();
        } else {
          return [
            jsonDecode(response.body)['response']['body']['items']['item']
                ['locdate']
          ];
        }
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }
}
