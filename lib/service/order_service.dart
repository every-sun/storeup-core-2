import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/language.dart';
import 'package:user_core2/model/order.dart';
import 'package:user_core2/service/service.dart';

class OrderServices2 {
  static Future<OrderRequestResponse> requestOrder(
      OrderRequestBody body) async {
    var response = await http.post(
      Uri.parse('${ServiceAPI().baseUrl}/orders'),
      body: jsonEncode(body.toJson()),
      headers: ServiceAPI().headerInfo,
    );
    print(jsonEncode(body.toJson()));
    return OrderRequestResponse.fromJson(jsonDecode(response.body));
  }

  static Future<OrderResponse> getOrders(dynamic customerId, String orderType,
      String from, String to, int page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI().baseUrl}/orders/customer/$customerId?from=$from&to=$to&order_type=$orderType&page=$page'),
      headers: ServiceAPI().headerInfo,
    ); // from, to:  2021-01-01
    print(jsonDecode(response.body));
    return OrderResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> requestOrderConfirm(
      dynamic customerId, itemId) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI().baseUrl}/customers/$customerId/items/$itemId'),
      headers: ServiceAPI().headerInfo,
    );
    print(jsonDecode(response.body));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }
}
