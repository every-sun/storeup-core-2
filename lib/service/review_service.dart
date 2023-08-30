import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/language.dart';
import 'package:user_core2/model/order.dart';
import 'package:user_core2/service/service.dart';

class ReviewServices2 {
  // static Future<BasicResponse> storeReview() async {
  //   var response = await http.post(
  //     Uri.parse('${ServiceAPI().baseUrl}/review/store'),
  //     headers: ServiceAPI().headerInfo,
  //   );
  //   return BasicResponse.fromJson(jsonDecode(response.body));
  // }

  static Future<List<OrderItem>> getOrderItems(
      customerId, int page, bool isReviewed) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI().baseUrl}/customers/$customerId/items?is_reviewed=$isReviewed&page=$page'),
      headers: ServiceAPI().headerInfo,
    );
    return List<OrderItem>.from(jsonDecode(response.body)['data']['data']
        .map((x) => OrderItem.fromJson(x)));
  }

  static Future<BasicResponse> deleteReview(customerId, dynamic id) async {
    var response = await http.delete(
      Uri.parse('${ServiceAPI().baseUrl}/review/delete/$id'),
      headers: ServiceAPI().headerInfo,
    );
    print(jsonDecode(response.body));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }
}
