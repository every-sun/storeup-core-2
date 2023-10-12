import 'package:user_core2/model/auth.dart';
import 'package:user_core2/model/product.dart';

class InquiryRequestBody {
  dynamic brandId;
  String inquiryType;
  String inquiryReason;
  String title;
  String contents;
  dynamic productId;
  bool isPrivate;
  List<dynamic>? images; // 없으면 널
  InquiryRequestBody(
      {required this.brandId,
      required this.inquiryType,
      required this.inquiryReason,
      required this.title,
      required this.contents,
      required this.productId,
      required this.isPrivate,
      required this.images});

  Map<String, String> toJson() {
    final Map<String, String> body = {};
    body['brand_id'] = brandId.toString();
    body['inquiry_type'] = inquiryType;
    body['inquiry_reason'] = inquiryReason;
    body['title'] = title;
    body['contents'] = contents;
    if (productId != null) body['product_id'] = productId.toString();
    body['is_private'] = isPrivate.toString();
    return body;
  }
}

class InquiryResponse {
  bool status;
  String message;
  InquiryResponseData? data;
  InquiryResponse(
      {required this.status, required this.message, required this.data});
  factory InquiryResponse.fromJson(Map<String, dynamic> json) =>
      InquiryResponse(
          status: json['status'],
          message: json['message'] ?? '',
          data: json['data'] != null
              ? InquiryResponseData.fromJson(json['data'])
              : null);
}

class InquiryResponseData {
  List<Inquiry> data;
  int total;
  InquiryResponseData({required this.data, required this.total});
  factory InquiryResponseData.fromJson(Map<String, dynamic> json) =>
      InquiryResponseData(
          data: json['data'] != null
              ? List<Inquiry>.from(json['data'].map((x) => Inquiry.fromJson(x)))
              : [],
          total: json['total'] ?? 0);
}

class Inquiry {
  dynamic id;
  dynamic brandId;
  dynamic customerId;
  dynamic productId;
  String inquiryType;
  String inquiryReason;
  String title;
  String contents;
  bool isAnswered;
  bool isPrivate;
  dynamic data;
  Product? product;
  DateTime createdAt;
  Customer? customer;
  Map? comment;
  Inquiry(
      {required this.id,
      required this.brandId,
      required this.customerId,
      required this.productId,
      required this.inquiryType,
      required this.inquiryReason,
      required this.title,
      required this.contents,
      required this.isAnswered,
      required this.isPrivate,
      required this.data,
      required this.product,
      required this.createdAt,
      required this.customer,
      required this.comment});

  factory Inquiry.fromJson(Map<dynamic, dynamic> json) => Inquiry(
      id: json['id'],
      brandId: json['brand_id'],
      customerId: json['customer_id'],
      productId: json['product_id'],
      inquiryType: json['inquiry_type'],
      inquiryReason: json['inquiry_reason'],
      title: json['title'],
      contents: json['contents'],
      isAnswered: json['is_answered'],
      isPrivate: json['is_private'],
      data: json['data'],
      product:
          json['product'] != null ? Product.fromJson(json['product']) : null,
      createdAt: DateTime.parse(json['created_at']),
      customer:
          json['customer'] != null ? Customer.fromJson(json['customer']) : null,
      comment: json['comments'] != null && json['comments'].isNotEmpty
          ? json['comments'][json['comments'].length - 1]
          : null);
}
