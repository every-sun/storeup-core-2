import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/language.dart';
import 'package:user_core2/service/service.dart';
import 'package:user_core2/model/auth.dart';

class AuthServices2 {
  static Future<SmsKeyResponse> getSmsKey(contact, brandId) async {
    var response = await http.get(Uri.parse(
        '${ServiceAPI().baseUrl}/sms/certification?contact=$contact&brand_id=$brandId'));
    return SmsKeyResponse.fromJson(jsonDecode(response.body));
  }

  static Future<RegisterResponse> register(RegisterRequestBody body) async {
    var response = await http.post(
        Uri.parse('${ServiceAPI().baseUrl}/auth/register'),
        body: jsonEncode(body.toJson()),
        headers: ServiceAPI().headerInfo);
    print(jsonDecode(response.body));
    return RegisterResponse.fromJson(jsonDecode(response.body));
  }

  static Future<LoginResponse> login(LoginRequestBody body) async {
    var response = await http.post(
        Uri.parse('${ServiceAPI().baseUrl}/auth/login'),
        body: jsonEncode(body.toJson()),
        headers: ServiceAPI().headerInfo);
    return LoginResponse.fromJson(jsonDecode(response.body));
  }

  static Future<UserExistResponse> userExistCheck(
      name, contact, brandId) async {
    var response = await http.get(Uri.parse(
        '${ServiceAPI().baseUrl}/auth/check/customer?name=$name&contact=$contact&brand_id=$brandId'));
    print(jsonDecode(response.body));
    return UserExistResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> emailUniqueCheck(email) async {
    // 이메일 중복확인
    var response = await http.get(
        Uri.parse('${ServiceAPI().baseUrl}/auth/validate/email?email=$email'));
    var value = BasicResponse.fromJson(jsonDecode(response.body));
    if (value.status) {
      return BasicResponse(message: '사용 가능한 이메일입니다.', status: true);
    } else {
      return BasicResponse(
          message: '이미 존재하는 이메일이거나\n이메일 형식에 맞지 않습니다.', status: false);
    }
  }

  /* 아이디 찾기, 비밀번호 재설정 */
  static Future<IdFindResponse> findId(name, contact, brandId) async {
    var response = await http.post(
        Uri.parse('${ServiceAPI().baseUrl}/auth/check/id'),
        headers: ServiceAPI().headerInfo,
        body: jsonEncode(
            {"name": name, "contact": contact, "brand_id": brandId}));
    return IdFindResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> resetPassword(email, password) async {
    var response =
        await http.post(Uri.parse('${ServiceAPI().baseUrl}/auth/reset'),
            headers: ServiceAPI().headerInfo,
            body: jsonEncode({
              "email": email,
              "password": password,
              "password_confirmation": password,
            }));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  // 비밀번호 체크
  static Future<BasicResponse> checkPassword(email, password) async {
    var response =
        await http.post(Uri.parse('${ServiceAPI().baseUrl}/auth/reset'),
            headers: ServiceAPI().headerInfo,
            body: jsonEncode({
              "email": email,
              "password": password,
            }));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  // 회원탈퇴
  static Future<BasicResponse> deleteCustomer(customerId) async {
    var response = await http.delete(
        Uri.parse('${ServiceAPI().baseUrl}/customers/$customerId'),
        headers: ServiceAPI().headerInfo);
    return BasicResponse.fromJson(jsonDecode(response.body));
  }
}
