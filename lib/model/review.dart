import 'package:user_core2/model/image_data.dart';
import 'package:user_core2/model/order.dart';

class ReviewRequestBody {
  dynamic brandId;
  dynamic customerId;
  String modelType;
  dynamic modelId;
  dynamic itemId;
  dynamic orderId;
  String contents;
  List<dynamic>? images; // 없으면 널

  ReviewRequestBody(
      {required this.brandId,
      required this.customerId,
      required this.modelType,
      required this.modelId,
      required this.itemId,
      required this.orderId,
      required this.contents,
      this.images});

  Map<String, String> toJson() {
    final Map<String, String> body = Map<String, String>();
    body['brand_id'] = brandId.toString();
    body['customer_id'] = customerId.toString();
    body['model_type'] = modelType;
    body['model_id'] = modelId.toString();
    body['item_id'] = itemId.toString();
    body['order_id'] = orderId.toString();
    body['contents'] = contents;
    return body;
  }
}

/* 상품 */
class ReviewResponse {
  bool status;
  String message;
  ReviewResponseData data;
  ReviewResponse(
      {required this.status, required this.message, required this.data});
  factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
      status: json['status'],
      message: json['message'] ?? '',
      data: ReviewResponseData.fromJson(json['data']));
}

class ReviewResponseData {
  List<OrderItem> data;
  int total;
  ReviewResponseData({required this.data, required this.total});
  factory ReviewResponseData.fromJson(Map<String, dynamic> json) =>
      ReviewResponseData(
          data: json['data'] != null
              ? List<OrderItem>.from(
                  json['data'].map((x) => OrderItem.fromJson(x)))
              : [],
          total: json['total'] ?? 0);
}

class Review {
  dynamic id;
  String contents;
  bool isBlocked;
  bool isReplied;
  ImageData? data;
  DateTime createdAt;
  Review(
      {required this.id,
      required this.contents,
      required this.isBlocked,
      required this.isReplied,
      required this.data,
      required this.createdAt});

  factory Review.fromJson(Map<String, dynamic> json) => Review(
      id: json['id'],
      contents: json['contents'] ?? '',
      isBlocked: json['is_blocked'],
      isReplied: json['is_replied'],
      data: json['data'] != null ? ImageData.fromJson(json['data']) : null,
      createdAt: DateTime.parse(json['created_at']));
}
