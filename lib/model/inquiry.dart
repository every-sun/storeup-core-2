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
    final Map<String, String> body = Map<String, String>();
    body['brand_id'] = brandId.toString();
    body['inquiry_type'] = inquiryType;
    body['inquiry_reason'] = inquiryReason;
    body['title'] = title;
    body['contents'] = contents;
    body['productId'] = productId.toString();
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
  DateTime createdAt;
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
      required this.createdAt});

  factory Inquiry.fromJson(Map<String, dynamic> json) => Inquiry(
        id: json['id'],
        brandId: json['brand_id'],
        customerId: json['customer_id'],
        productId: json['product_id'],
        inquiryType: json['inquiry_id'],
        inquiryReason: json['inquiry_reason'],
        title: json['title'],
        contents: json['contents'],
        isAnswered: json['is_answered'],
        isPrivate: json['is_private'],
        data: json['data'],
        createdAt: DateTime.parse(json['created_at']),
      );
}
