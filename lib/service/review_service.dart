import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/language.dart';
import 'package:user_core2/model/review.dart';
import 'package:user_core2/service/service.dart';

class ReviewServices2 {
  /* 리뷰 작성 가능한 주문 아이템들 */
  static Future<ReviewResponse> getOrderItems(customerId, int page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI.baseUrl}/customers/$customerId/items/reviews?&page=$page'),
      headers: ServiceAPI.headerInfo,
    );
    return ReviewResponse.fromJson(jsonDecode(response.body));
  }

  static Future<ModelReviewResponse> getReviewsByProduct(
      productId, int page) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI.baseUrl}/products/$productId/reviews?page=$page'),
      headers: ServiceAPI.headerInfo,
    );
    return ModelReviewResponse.fromJson(jsonDecode(response.body));
  }

  static Future<ModelReviewResponse> getReviewsByStore(
      brandId, tenantId, int page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI.baseUrl}/brands/$brandId/stores/$tenantId/reviews?page=$page'),
      headers: ServiceAPI.headerInfo,
    );
    return ModelReviewResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> deleteReview(customerId, dynamic id) async {
    var response = await http.delete(
      Uri.parse(
          '${ServiceAPI.baseUrl}/customers/$customerId/reviews/delete/$id'),
      headers: ServiceAPI.headerInfo,
    );
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<ModelReviewResponse> getReviews(
      customerId, String type, int page) async {
    var response = await http.get(
        Uri.parse(
            '${ServiceAPI.baseUrl}/customers/$customerId/reviews?type=$type&page=$page'),
        headers: ServiceAPI.headerInfo);
    return ModelReviewResponse.fromJson(jsonDecode(response.body));
  }
}
