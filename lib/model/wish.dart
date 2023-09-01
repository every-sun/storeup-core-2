import 'package:user_core2/model/product.dart';

class WishResponse {
  bool status;
  String message;
  WishResponseData? data;
  WishResponse(
      {required this.status, required this.message, required this.data});
  factory WishResponse.fromJson(Map<String, dynamic> json) => WishResponse(
      status: json['status'],
      message: json['message'] ?? '',
      data: json['data'] != null
          ? WishResponseData.fromJson(json['data'])
          : null);
}

class WishResponseData {
  List<Wish> data;
  int total;
  WishResponseData({required this.data, required this.total});
  factory WishResponseData.fromJson(Map<String, dynamic> json) =>
      WishResponseData(
          data: json['data'] != null
              ? List<Wish>.from(json['data'].map((x) => Wish.fromJson(x)))
              : [],
          total: json['total'] ?? 0);
}

class Wish {
  dynamic id;
  dynamic productId;
  Product product;
  Wish({required this.id, required this.productId, required this.product});
  factory Wish.fromJson(Map<String, dynamic> json) => Wish(
      id: json['id'],
      productId: json['product_id'],
      product: Product.fromJson(json['product']));
}
