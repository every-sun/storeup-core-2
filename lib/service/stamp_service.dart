import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/language.dart';
import 'package:user_core2/service/service.dart';

class StampServices {
  static Future<Map> getStamps(customerId) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI.baseUrl}/customers/$customerId/stamps'),
      headers: ServiceAPI.headerInfo,
    );
    return jsonDecode(response.body);
  }

  static Future<BasicResponse> updateStampNo(customerId, stampNo) async {
    var response = await http.put(
      Uri.parse(
          '${ServiceAPI.baseUrl}/customers/$customerId/stamps?stamp_no=$stampNo'),
      headers: ServiceAPI.headerInfo,
    );
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> getReward(customerId) async {
    var response = await http.post(
      Uri.parse('${ServiceAPI.baseUrl}/customers/$customerId/stamps/reward'),
      headers: ServiceAPI.headerInfo,
    );
    return BasicResponse.fromJson(jsonDecode(response.body));
  }
}
