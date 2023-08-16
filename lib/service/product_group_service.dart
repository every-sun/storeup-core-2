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
    return ProductGroupResponse.fromJson(jsonDecode(response.body));
  }

  /* 단일 상품그룹 조회 */
  static Future<ProductGroup> getProductGroup(groupId) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI().baseUrl}/groups/$groupId'),
      headers: ServiceAPI().headerInfo,
    );
    return ProductGroup.fromJson(jsonDecode(response.body)['data']);
  }
}
