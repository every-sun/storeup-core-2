import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/product.dart';
import 'package:user_core2/service/service.dart';

class ProductServices2 {
  static Future<ProductResponse> getProductsByGroup(
      groupId, orderBy, direction, page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI().baseUrl}/products/group/$groupId?order_by=$orderBy&direction=$direction&count=20&page=$page'),
      headers: ServiceAPI().headerInfo,
    );
    print(jsonDecode(response.body));
    return ProductResponse.fromJson(jsonDecode(response.body));
  }
}
