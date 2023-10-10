import 'package:user_core2/model/order.dart';
import 'package:user_core2/model/store.dart';

class ReviewRequestBody {
  dynamic brandId;
  dynamic customerId;
  String modelType; // 장보기: 'product', 'store'
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
    final Map<String, String> body = {};
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

class ReviewResponse {
  bool status;
  String message;
  ReviewResponseData? data;
  ReviewResponse(
      {required this.status, required this.message, required this.data});
  factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
      status: json['status'],
      message: json['message'] ?? '',
      data: json['data'] != null
          ? ReviewResponseData.fromJson(json['data'])
          : null);
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

class ModelReviewResponse {
  bool status;
  String message;
  ModelReviewResponseData? data;
  ModelReviewResponse(
      {required this.status, required this.message, required this.data});
  factory ModelReviewResponse.fromJson(Map<String, dynamic> json) =>
      ModelReviewResponse(
          status: json['status'],
          message: json['message'] ?? '',
          data: json['data'] != null
              ? ModelReviewResponseData.fromJson(json['data'])
              : null);
}

class ModelReviewResponseData {
  List<Review> data;
  int total;
  ModelReviewResponseData({required this.data, required this.total});
  factory ModelReviewResponseData.fromJson(Map<String, dynamic> json) =>
      ModelReviewResponseData(
          data: json['data'] != null
              ? List<Review>.from(json['data'].map((x) => Review.fromJson(x)))
              : [],
          total: json['total'] ?? 0);
}

class Review {
  dynamic id;
  String contents;
  bool isBlocked;
  bool isReplied;
  ReviewData? data;
  DateTime createdAt;
  List<dynamic> orderItems;
  Store? store;
  Map? comment;
  Review(
      {required this.id,
      required this.contents,
      required this.isBlocked,
      required this.isReplied,
      required this.data,
      required this.createdAt,
      required this.orderItems,
      required this.store,
      required this.comment});

  factory Review.fromJson(Map<String, dynamic> json) => Review(
      id: json['id'],
      contents: json['contents'] ?? '',
      isBlocked: json['is_blocked'],
      isReplied: json['is_replied'],
      data: json['data'] != null ? ReviewData.fromJson(json['data']) : null,
      createdAt: DateTime.parse(json['created_at']),
      orderItems: (json['order'] != null && json['order']['items'] != null)
          ? json['order']['items']
          : [],
      store: (json['order'] != null &&
              json['order']['stores'] != null &&
              json['order']['stores'].isNotEmpty)
          ? Store.fromJson(json['order']['stores'][0])
          : null,
      comment: json['comments'] != null && json['comments'].isNotEmpty
          ? json['comments'][json['comments'].length - 1]
          : null);
}

class ReviewData {
  String writer;
  Map<String, dynamic>? images;
  ReviewData({required this.writer, required this.images});
  factory ReviewData.fromJson(Map<String, dynamic> json) =>
      ReviewData(writer: json['writer'] ?? '', images: json['images']);
}
