import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/cart.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/service/service.dart';

class CartServices {
  static Future<BasicResponse> storeCart(
      customerId, CartRequestBody body) async {
    var response = await http.post(
      Uri.parse('${ServiceAPI.baseUrl}/customers/$customerId/carts'),
      body: jsonEncode(body.toJson()),
      headers: ServiceAPI.headerInfo,
    );
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<CartResponse> getCarts(
      customerId, String cartType, page, count) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI.baseUrl}/customers/$customerId/carts?cart_type=$cartType&order_by=created_at&direction=DESC&page=$page&count=$count'),
      headers: ServiceAPI.headerInfo,
    );
    return CartResponse.fromJson(jsonDecode(response.body));
  }

  static Future<int> getCartTotal(customerId, String cartType) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI.baseUrl}/customers/$customerId/carts/count?cart_type=$cartType'),
      headers: ServiceAPI.headerInfo,
    );
    return jsonDecode(response.body)['data'] ?? 0;
  }

  static Future<BasicResponse> updateQuantity(
      customerId, cartId, int quantity) async {
    var response = await http.put(
      Uri.parse(
          '${ServiceAPI.baseUrl}/customers/$customerId/carts/$cartId?quantity=$quantity'),
      headers: ServiceAPI.headerInfo,
    );
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> changeCartType(customerId, body) async {
    var response = await http.put(
        Uri.parse('${ServiceAPI.baseUrl}/customers/$customerId/carts/shipping'),
        headers: ServiceAPI.headerInfo,
        body: jsonEncode(body));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> deleteCarts(
      customerId, List<dynamic> cartIdList) async {
    var response = await http.delete(
      Uri.parse('${ServiceAPI.baseUrl}/customers/$customerId/carts'),
      headers: ServiceAPI.headerInfo,
      body: jsonEncode({'id_list': cartIdList}),
    );
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  /* 배달 장바구니 모두 비우기 (주문 성공 후) */
  static Future<BasicResponse> clearDeliveryCarts(customerId) async {
    var response = await http.delete(
      Uri.parse('${ServiceAPI.baseUrl}/customers/$customerId/carts/delivery'),
      headers: ServiceAPI.headerInfo,
    );
    return BasicResponse.fromJson(jsonDecode(response.body));
  }
}
