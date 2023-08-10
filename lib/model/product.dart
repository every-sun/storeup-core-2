import 'package:user_core2/model/language.dart';

/* 상품 */
class ProductResponse {
  bool status;
  ProductResponseData? data;
  ProductResponse({required this.status, required this.data});
  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
          status: json['status'],
          data: ProductResponseData.fromJson(json['data']));
}

class ProductResponseData {
  List<Product> data;
  int total;
  ProductResponseData({required this.data, required this.total});
  factory ProductResponseData.fromJson(Map<String, dynamic> json) =>
      ProductResponseData(
          data: json['data'] != null
              ? List<Product>.from(json['data'].map((x) => Product.fromJson(x)))
              : [],
          total: json['total'] ?? 0);
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
  AdditionalInfo? now;

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
      name: json['name'] != null ? Language.fromJson(json['name']).ko : '',
      description: json['description'] != null
          ? Language.fromJson(json['description']).ko
          : '',
      noticeInformation: json['product_group_id'],
      detailContents: json['detail_contents'],
      taxType: json['tax_type'],
      taxRate: json['tax_rate'],
      isOnline: json['is_online'] == 1 ? true : false,
      isDelivery: json['is_delivery'] == 1 ? true : false,
      isNow: json['is_now'] == 1 ? true : false,
      online: AdditionalInfo.fromJson(json['online']),
      now: json['now'] != null ? AdditionalInfo.fromJson(json['now']) : null);
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
        description: json['description'] != null
            ? Language.fromJson(json['description']).ko
            : '',
        isPurchasable: json['is_purchasable'] == 1 ? true : false,
        isTemporarySoldOut: json['is_temporary_sold_out'] == 1 ? true : false,
        isManageStock: json['is_manage_stock'] == 1 ? true : false,
        stockQuantity: json['stock_quantity'],
        safetyInventory: json['safety_inventory'],
      );
}

/* -----상품---- */

/* 상품 컬렉션 */
class ProductCollectionResponse {
  bool status;
  ProductCollectionData? data;
  ProductCollectionResponse({required this.status, required this.data});
  factory ProductCollectionResponse.fromJson(Map<String, dynamic> json) =>
      ProductCollectionResponse(
          status: json['status'],
          data: ProductCollectionData.fromJson(json['data']));
}

class ProductCollectionData {
  List<ProductCollection> data;
  int total;
  ProductCollectionData({required this.data, required this.total});
  factory ProductCollectionData.fromJson(Map<String, dynamic> json) =>
      ProductCollectionData(
          data: json['data'] != null
              ? List<ProductCollection>.from(
                  json['data'].map((x) => Product.fromJson(x)))
              : [],
          total: json['total'] ?? 0);
}

class ProductCollection {
  dynamic id;
  String name;
  String description;
  List<Product> products;
  int total;
  ProductCollection(
      {required this.id,
      required this.name,
      required this.description,
      required this.products,
      required this.total});
  factory ProductCollection.fromJson(Map<String, dynamic> json) =>
      ProductCollection(
        id: json['id'],
        name: json['name'] != null ? Language.fromJson(json['name']).ko : '',
        description: json['description'] != null
            ? Language.fromJson(json['description']).ko
            : '',
        products: json['products'] != null
            ? List<Product>.from(json['data'].map((x) => Product.fromJson(x)))
            : [],
        total: json['total'] ?? 0,
      );
}
/*----- 상품 컬렉션 -----*/
