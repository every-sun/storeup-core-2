import 'package:user_core2/model/language.dart';

/* 상품 */
class ProductResponse {
  bool status;
  String message;
  ProductResponseData data;
  ProductResponse(
      {required this.status, required this.message, required this.data});
  factory ProductResponse.fromJson(Map<String, dynamic> json) =>
      ProductResponse(
          status: json['status'],
          message: json['message'] ?? '',
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
  String? taxType;
  String? taxRate;
  bool isOnline;
  bool isDelivery;
  bool isNow;
  ProductOnline online;
  ProductData? data;
  List<ProductOption> options;
  Map<String, dynamic> store;
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
      required this.data,
      required this.options,
      required this.store});
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
      isOnline: json['is_online'] == 1,
      isDelivery: json['is_delivery'] == 1,
      isNow: json['is_now'] == 1,
      online: ProductOnline.fromJson(json['online']),
      data: json['data'] != null ? ProductData.fromJson(json['data']) : null,
      options: json['options'] != null
          ? List<ProductOption>.from(
              json['options'].map((x) => ProductOption.fromJson(x)))
          : [],
      store: json['store'] ?? {});
}

class ProductOption {
  dynamic id;
  String optionType;
  dynamic optionId;
  String name;
  String description;
  int min;
  int max;
  bool isParent;
  int optionPrice;
  List<ProductOption> childrenOptions;
  ProductOption(
      {required this.id,
      required this.optionType,
      required this.optionId,
      required this.name,
      required this.description,
      required this.min,
      required this.max,
      required this.isParent,
      required this.optionPrice,
      required this.childrenOptions});
  factory ProductOption.fromJson(Map<String, dynamic> json) => ProductOption(
      id: json['id'],
      optionType: json['option_type'],
      optionId: json['option_id'],
      name: json['name'] != null ? Language.fromJson(json['name']).ko : '',
      description: json['description'] != null
          ? Language.fromJson(json['description']).ko
          : '',
      min: json['min'],
      max: json['max'],
      isParent: json['is_parent'],
      optionPrice: json['option_price'],
      childrenOptions: json['children_options'] != null
          ? List<ProductOption>.from(
              json['children_options'].map((x) => ProductOption.fromJson(x)))
          : []);

  factory ProductOption.clone(ProductOption productOption) {
    return ProductOption(
        id: productOption.id,
        optionType: productOption.optionType,
        optionId: productOption.optionId,
        name: productOption.name,
        description: productOption.description,
        min: productOption.min,
        max: productOption.max,
        isParent: productOption.isParent,
        optionPrice: productOption.optionPrice,
        childrenOptions: productOption.childrenOptions);
  }
}

class ProductData {
  String thumbnail;
  Map<String, dynamic>? images;
  ProductData({required this.thumbnail, this.images});
  factory ProductData.fromJson(Map<String, dynamic> json) => ProductData(
      thumbnail:
          json['thumbnail'] != null ? json['thumbnail'].values.toList()[0] : '',
      images: json['images']);
}

class ProductOnline {
  dynamic id;
  dynamic productId;
  int price;
  String description;
  bool isPurchasable;
  bool isTemporarySoldOut;
  bool isManageStock;
  int stockQuantity;
  int safetyInventory;
  String discountType;
  int discountPrice;
  int discountAmount;
  int discountPercentage;
  int purchasableQuantityMin;
  int purchasableQuantityMax;
  ProductOnline(
      {required this.id,
      required this.productId,
      required this.price,
      required this.description,
      required this.isPurchasable,
      required this.isTemporarySoldOut,
      required this.isManageStock,
      required this.stockQuantity,
      required this.safetyInventory,
      required this.discountType,
      required this.discountPrice,
      required this.discountAmount,
      required this.discountPercentage,
      required this.purchasableQuantityMin,
      required this.purchasableQuantityMax});
  factory ProductOnline.fromJson(Map<String, dynamic> json) => ProductOnline(
      id: json['id'],
      productId: json['product_id'],
      price: json['price'],
      description: json['description'] != null
          ? Language.fromJson(json['description']).ko
          : '',
      isPurchasable: json['is_purchasable'] == 1,
      isTemporarySoldOut: json['is_temporary_sold_out'] == 1,
      isManageStock: json['is_manage_stock'] == 1,
      stockQuantity: json['stock_quantity'],
      safetyInventory: json['safety_inventory'],
      discountType: json['discount_type'],
      discountPrice: json['discount_price'],
      discountAmount: json['discount_amount'],
      discountPercentage: json['discount_percentage'],
      purchasableQuantityMin: json['purchasable_quantity_min'],
      purchasableQuantityMax: json['purchasable_quantity_max']);
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
  List<ProductCollection> productCollections;
  int total;
  ProductCollectionData(
      {required this.productCollections, required this.total});
  factory ProductCollectionData.fromJson(Map<String, dynamic> json) =>
      ProductCollectionData(
          productCollections: json['data'] != null
              ? List<ProductCollection>.from(
                  json['data'].map((x) => ProductCollection.fromJson(x)))
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
            ? List<Product>.from(
                json['products'].map((x) => Product.fromJson(x)))
            : [],
        total: json['total'] ?? 0,
      );
}
/*----- 상품 컬렉션 -----*/
