import 'package:user_core2/model/image_data.dart';

class ReviewRequestBody {
  dynamic brandId;
  dynamic customerId;
  String modelType;
  dynamic modelId;
  dynamic itemId; // orderItem의 global_id
  dynamic orderId; // order의 global_id
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
      contents: json['contents'],
      isBlocked: json['is_blocked'],
      isReplied: json['is_replied'],
      data: json['data'] != null ? ImageData.fromJson(json['data']) : null,
      createdAt: DateTime.parse(json['created_at']));
}
