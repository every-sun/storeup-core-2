/* 상품 */
import 'package:user_core2/model/language.dart';

class ProductResponse {
  bool status;
  List<Product> data;
  ProductResponse({required this.status, required this.data});
  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
          status: json['status'],
          data: json['data'] != null
              ? List<Product>.from(json['data'].map((x) => Product.fromJson(x)))
              : []);
}

class Product {
  dynamic id;
  dynamic globalId;
  String name;
  String description;
  dynamic noticeInformation; // TODO
  dynamic detailContents; // TODO
  String taxType;
  String taxRate;
  bool isOnline;
  bool isDelivery;
  bool isNow;
  AdditionalInfo online;
  AdditionalInfo now;

  Product(
      {required this.id,
      required this.globalId,
      required this.name,
      required this.description,
      required this.noticeInformation,
      required this.detailContents,
      required this.taxType,
      required this.taxRate,
      required this.isOnline,
      required this.isDelivery,
      required this.isNow,
      required this.online,
      required this.now});
  factory Product.fromJson(Map<String, dynamic> json) => Product(
      id: json['id'],
      globalId: json['global_id'],
      name: Language.fromJson(json['name']).ko,
      description: Language.fromJson(json['description']).ko,
      noticeInformation: json['product_group_id'],
      detailContents: json['detail_contents'],
      taxType: json['tax_type'],
      taxRate: json['tax_rate'],
      isOnline: json['is_online'],
      isDelivery: json['is_delivery'],
      isNow: json['is_now'],
      online: AdditionalInfo.fromJson(json['online']),
      now: AdditionalInfo.fromJson(json['now']));
}

class AdditionalInfo {
  dynamic id;
  dynamic productId;
  int price;
  String description;
  bool isPurchasable;
  bool isTemporarySoldOut;
  bool isManageStock;
  int stockQuantity;
  int safetyInventory;
  AdditionalInfo(
      {required this.id,
      required this.productId,
      required this.price,
      required this.description,
      required this.isPurchasable,
      required this.isTemporarySoldOut,
      required this.isManageStock,
      required this.stockQuantity,
      required this.safetyInventory});
  factory AdditionalInfo.fromJson(Map<String, dynamic> json) => AdditionalInfo(
        id: json['id'],
        productId: json['product_id'],
        price: json['price'],
        description: Language.fromJson(json['description']).ko,
        isPurchasable: json['is_purchasable'] == 1 ? true : false,
        isTemporarySoldOut: json['is_temporary_sold_out'] == 1 ? true : false,
        isManageStock: json['is_manage_stock'] == 1 ? true : false,
        stockQuantity: json['stock_quantity'],
        safetyInventory: json['safety_inventory'],
      );
}

/* -----상품---- */
