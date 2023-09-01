import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/language.dart';
import 'package:user_core2/model/review.dart';
import 'package:user_core2/service/service.dart';

class ReviewServices2 {
  static Future<ReviewResponse> getOrderItems(
      // 나의 리뷰 가져오기 (isReviewed true = 리뷰가 달린 주문 아이템들 / false = 작성 가능한 주문 아이템들)
      customerId,
      int page,
      bool isReviewed) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI().baseUrl}/customers/$customerId/items?is_reviewed=$isReviewed&page=$page'),
      headers: ServiceAPI().headerInfo,
    );
    return ReviewResponse.fromJson(jsonDecode(response.body));
  }

  static Future<ModelReviewResponse> getReviewsByProduct(
      productId, int page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI().baseUrl}/products/$productId/reviews?page=$page'),
      headers: ServiceAPI().headerInfo,
    );
    print(jsonDecode(response.body));
    return ModelReviewResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> deleteReview(customerId, dynamic id) async {
    var response = await http.delete(
      Uri.parse(
          '${ServiceAPI().baseUrl}/customers/$customerId/review/delete/$id'),
      headers: ServiceAPI().headerInfo,
    );
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> editReview(
      customerId, dynamic id, contents) async {
    var response = await http.put(
        Uri.parse(
            '${ServiceAPI().baseUrl}/customers/$customerId/review/edit/$id'),
        headers: ServiceAPI().headerInfo,
        body: jsonEncode({'contents': contents}));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }
}
