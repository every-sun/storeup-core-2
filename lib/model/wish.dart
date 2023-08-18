import 'package:user_core2/model/product.dart';

class WishResponse {
  int total;
  List<Wish> data;
  WishResponse({required this.total, required this.data});
  factory WishResponse.fromJson(Map<String, dynamic> json) => WishResponse(
      total: json['total'],
      data: json['data'] != null
          ? List<Wish>.from(json['data'].map((x) => Wish.fromJson(x)))
          : []);
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
