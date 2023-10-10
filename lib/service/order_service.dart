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
    return OrderRequestResponse.fromJson(jsonDecode(response.body));
  }

  static Future<OrderResponse> getOrders(dynamic customerId, String orderType,
      String from, String to, int page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI().baseUrl}/orders/customer/$customerId?from=$from&to=$to&order_type=$orderType&page=$page'),
      headers: ServiceAPI().headerInfo,
    ); // from, to:  2021-01-01
    return OrderResponse.fromJson(jsonDecode(response.body));
  }

  static Future<Order> getOrder(dynamic id) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI().baseUrl}/orders/$id'),
      headers: ServiceAPI().headerInfo,
    ); // from, to:  2021-01-01
    return Order.fromJson(jsonDecode(response.body)['data']);
  }

  static Future<BasicResponse> requestOrderConfirm(
      dynamic customerId, itemId) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI().baseUrl}/customers/$customerId/items/$itemId'),
      headers: ServiceAPI().headerInfo,
    );
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> deleteUnpaidOrder(orderId) async {
    var response = await http.delete(
      Uri.parse('${ServiceAPI().baseUrl}/orders/$orderId'),
      headers: ServiceAPI().headerInfo,
    );
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> restoreToCart(dynamic customerId, itemId) async {
    var response = await http.post(
        Uri.parse('${ServiceAPI().baseUrl}/customers/$customerId/carts'),
        headers: ServiceAPI().headerInfo,
        body: jsonEncode({'item_id': itemId, 'cart_type': 'O'}));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }
}
