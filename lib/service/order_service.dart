import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/language.dart';
import 'package:user_core2/model/order.dart';
import 'package:user_core2/service/service.dart';

class OrderServices2 {
  static Future<BasicResponse> requestOrder(OrderRequestBody body) async {
    var response = await http.post(
      Uri.parse('${ServiceAPI().baseUrl}/orders'),
      body: jsonEncode(body.toJson()),
      headers: ServiceAPI().headerInfo,
    );
    return BasicResponse.fromJson(jsonDecode(response.body));
  }
}
