import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/product_group.dart';
import 'package:user_core2/service/service.dart';

class ProductGroupServices2 {
  static Future<ProductGroupResponse> getProductGroups(brandId) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI().baseUrl}/groups?brand_id=$brandId'),
      headers: ServiceAPI().headerInfo,
    );
    print(jsonDecode(response.body));
    return ProductGroupResponse.fromJson(jsonDecode(response.body));
  }
}
