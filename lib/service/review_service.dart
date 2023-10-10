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
    return ModelReviewResponse.fromJson(jsonDecode(response.body));
  }

  //. 상점 리뷰
  static Future<ModelReviewResponse> getReviewsByStore(
      brandId, tenantId, int page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI().baseUrl}/brands/$brandId/stores/$tenantId/reviews?page=$page'),
      headers: ServiceAPI().headerInfo,
    );
    return ModelReviewResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> deleteReview(customerId, dynamic id) async {
    var response = await http.delete(
      Uri.parse(
          '${ServiceAPI().baseUrl}/customers/$customerId/reviews/delete/$id'),
      headers: ServiceAPI().headerInfo,
    );
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> editReview(
      customerId, dynamic id, contents) async {
    var response = await http.put(
        Uri.parse(
            '${ServiceAPI().baseUrl}/customers/$customerId/reviews/edit/$id'),
        headers: ServiceAPI().headerInfo,
        body: jsonEncode({'contents': contents}));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<ModelReviewResponse> getOrderReviews(
      // 주문에 달린 리뷰들 (사용자 배달 주문 리뷰 리스트)
      customerId,
      int page) async {
    var response = await http.get(
        Uri.parse(
            '${ServiceAPI().baseUrl}/customers/$customerId/reviews/orders?page=$page'),
        headers: ServiceAPI().headerInfo);
    return ModelReviewResponse.fromJson(jsonDecode(response.body));
  }
}
