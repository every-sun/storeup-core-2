import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/language.dart';
import 'package:user_core2/model/wish.dart';
import 'package:user_core2/service/service.dart';

class WishServices2 {
  static Future<BasicResponse> toggleWish(customerId, productId) async {
    var response = await http.post(
        Uri.parse('${ServiceAPI().baseUrl}/wish/toggle'),
        headers: ServiceAPI().headerInfo,
        body: jsonEncode({"customer_id": customerId, "product_id": productId}));
    print(jsonDecode(response.body));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<WishResponse> getWishes(customerId, page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI().baseUrl}/wish?customer_id=$customerId&page=$page'),
      headers: ServiceAPI().headerInfo,
    );
    return WishResponse.fromJson(jsonDecode(response.body));
  }
}
