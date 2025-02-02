import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/language.dart';
import 'package:user_core2/model/wish.dart';
import 'package:user_core2/service/service.dart';

class WishServices {
  static Future<BasicResponse> storeWish(customerId, productId) async {
    var response = await http.post(
        Uri.parse('${ServiceAPI.baseUrl}/customers/$customerId/wishes/store'),
        headers: ServiceAPI.headerInfo,
        body: jsonEncode({"customer_id": customerId, "product_id": productId}));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> deleteWish(customerId, productId) async {
    var response = await http.delete(
        Uri.parse('${ServiceAPI.baseUrl}/customers/$customerId/wishes/delete'),
        headers: ServiceAPI.headerInfo,
        body: jsonEncode({"product_id": productId}));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> deleteAllWish(customerId) async {
    var response = await http.delete(
      Uri.parse(
          '${ServiceAPI.baseUrl}/customers/$customerId/wishes/all/delete'),
      headers: ServiceAPI.headerInfo,
    );
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<WishResponse> getWishes(customerId, page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI.baseUrl}/customers/$customerId/wishes?page=$page'),
      headers: ServiceAPI.headerInfo,
    );
    return WishResponse.fromJson(jsonDecode(response.body));
  }

  // 상품이 사용자 찜 리스트에 포함되어있는지 bool 값으로 응답
  static Future<bool> checkWish(customerId, productId) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI.baseUrl}/customers/$customerId/wishes/item?product_id=$productId'),
      headers: ServiceAPI.headerInfo,
    );
    return jsonDecode(response.body)['data'] ?? false;
  }
}
