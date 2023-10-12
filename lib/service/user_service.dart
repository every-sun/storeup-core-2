import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/language.dart';
import 'package:user_core2/service/service.dart';
import 'package:user_core2/model/auth.dart';

class UserServices {
  // 사용자 정보 업데이트
  static Future<BasicResponse> updateCustomer(
      Map body, dynamic customerId) async {
    var response = await http.put(
        Uri.parse('${ServiceAPI().baseUrl}/customers/$customerId'),
        headers: ServiceAPI().headerInfo,
        body: jsonEncode(body));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  // 사용자 조회
  static Future<CustomerResponse> getCustomer(dynamic customerId) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI().baseUrl}/customers/$customerId'),
      headers: ServiceAPI().headerInfo,
    );
    return CustomerResponse.fromJson(jsonDecode(response.body));
  }

  // 사용자 동의여부 조회
  static Future<Map<dynamic, dynamic>> getAgreementInfo(
      dynamic customerId) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI().baseUrl}/customers/$customerId/agreement'),
      headers: ServiceAPI().headerInfo,
    );
    return jsonDecode(response.body)['data'];
  }

  // 사용자 동의 여부 업데이트
  static Future<BasicResponse> updateAgreementInfo(
      Map body, dynamic customerId) async {
    var response = await http.put(
        Uri.parse('${ServiceAPI().baseUrl}/customers/$customerId/agreement'),
        headers: ServiceAPI().headerInfo,
        body: jsonEncode(body));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> updateRefundAccount(
      Map body, dynamic customerId) async {
    var response = await http.put(
        Uri.parse('${ServiceAPI().baseUrl}/customers/$customerId/account'),
        headers: ServiceAPI().headerInfo,
        body: jsonEncode(body));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> resetRefundAccount(dynamic customerId) async {
    var response = await http.put(
      Uri.parse('${ServiceAPI().baseUrl}/customers/$customerId/account/reset'),
      headers: ServiceAPI().headerInfo,
    );
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> updateDeviceToken(
      dynamic customerId, token) async {
    var response = await http.put(
        Uri.parse('${ServiceAPI().baseUrl}/customers/$customerId/token'),
        headers: ServiceAPI().headerInfo,
        body: jsonEncode({'device_token': token}));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }
}
