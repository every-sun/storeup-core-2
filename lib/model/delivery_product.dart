import 'package:user_core2/model/language.dart';
import 'package:user_core2/model/product.dart';

class DeliveryProductsByCategoryResponse {
  bool status;
  String message;
  List<DeliveryProductsByCategoryData>? data;
  DeliveryProductsByCategoryResponse(
      {required this.status, required this.message, required this.data});
  factory DeliveryProductsByCategoryResponse.fromJson(
          Map<String, dynamic> json) =>
      DeliveryProductsByCategoryResponse(
          status: json['status'],
          message: json['message'] ?? '',
          data: json['data'] != null
              ? List<DeliveryProductsByCategoryData>.from(json['data']
                  .map((x) => DeliveryProductsByCategoryData.fromJson(x)))
              : null);
}

class DeliveryProductsByCategoryData {
  dynamic id;
  String name;
  String description;
  List<DeliveryProductsByCategory> deliveries;
  DeliveryProductsByCategoryData(
      {required this.id,
      required this.name,
      required this.description,
      required this.deliveries});
  factory DeliveryProductsByCategoryData.fromJson(Map<String, dynamic> json) =>
      DeliveryProductsByCategoryData(
          id: json['id'],
          name: json['name'] != null ? Language.fromJson(json['name']).ko : '',
          description: json['description'] != null
              ? Language.fromJson(json['description']).ko
              : '',
          deliveries: json['deliveries'] != null
              ? List<DeliveryProductsByCategory>.from(json['deliveries']
                  .map((x) => DeliveryProductsByCategory.fromJson(x)))
              : []);
}

class DeliveryProductsByCategory {
  dynamic id;
  int price;
  bool isDiscount;
  String discountType;
  int discountPrice;
  int discountAmount;
  int discountPercentage;
  int purchasableQuantityMin;
  int purchasableQuantityMax;
  bool isPurchasable;
  bool isManageStock;
  bool isTemporarySoldOut;
  int stockQuantity;
  int safetyInventory;
  DeliveryProduct? product;

  DeliveryProductsByCategory({
    required this.id,
    required this.price,
    required this.isDiscount,
    required this.discountType,
    required this.discountPrice,
    required this.discountAmount,
    required this.discountPercentage,
    required this.purchasableQuantityMin,
    required this.purchasableQuantityMax,
    required this.isPurchasable,
    required this.isManageStock,
    required this.isTemporarySoldOut,
    required this.stockQuantity,
    required this.safetyInventory,
    required this.product,
  });
  factory DeliveryProductsByCategory.fromJson(Map<String, dynamic> json) =>
      DeliveryProductsByCategory(
          id: json['id'],
          price: json['price'],
          isDiscount: json['is_discount'],
          discountType: json['discount_type'],
          discountPrice: json['discount_price'],
          discountAmount: json['discount_amount'],
          discountPercentage: json['discount_percentage'],
          purchasableQuantityMin: json['purchasable_quantity_min'],
          purchasableQuantityMax: json['purchasable_quantity_max'],
          isPurchasable: json['is_purchasable'],
          isManageStock: json['is_manage_stock'],
          isTemporarySoldOut: json['is_temporary_sold_out'],
          stockQuantity: json['stock_quantity'],
          safetyInventory: json['safety_inventory'],
          product: json['product'] != null
              ? DeliveryProduct.fromJson(json['product'])
              : null);
}

class DeliveryProduct {
  dynamic id;
  dynamic globalId;
  String name;
  String description;
  Map noticeInformation; // {'title': 공통, 'data': {}}
  String? detailContents;
  ImageData? data;

  DeliveryProduct(
      {required this.id,
      required this.globalId,
      required this.name,
      required this.description,
      required this.noticeInformation,
      required this.data,
      required this.detailContents});
  factory DeliveryProduct.fromJson(Map<String, dynamic> json) =>
      DeliveryProduct(
        id: json['id'],
        globalId: json['global_id'],
        name: json['name'] != null ? Language.fromJson(json['name']).ko : '',
        description: json['description'] != null
            ? Language.fromJson(json['description']).ko
            : '',
        noticeInformation: json['notice_information'],
        detailContents: json['detail_contents'],
        data: json['data'] != null ? ImageData.fromJson(json['data']) : null,
      );
}

class DeliveryDetail {
  // 배달 상품 상세페이지(장바구니에 추가하는 페이지)
  dynamic id;
  dynamic globalId;
  dynamic tenantId;
  String name;
  String description;
  Map noticeInformation; // {'title': 공통, 'data': {}}
  String? detailContents;
  ImageData? data;
  Map store; // {'store_name', 'tenant_id'}
  List<ProductOption> options;
  DeliveryDetailInfo delivery;
  DeliveryDetail(
      {required this.id,
      required this.globalId,
      required this.tenantId,
      required this.name,
      required this.description,
      required this.noticeInformation,
      required this.detailContents,
      required this.data,
      required this.store,
      required this.options,
      required this.delivery});
  factory DeliveryDetail.fromJson(Map<String, dynamic> json) => DeliveryDetail(
      id: json['id'],
      globalId: json['global_id'],
      tenantId: json['tenant_id'],
      name: json['name'] != null ? Language.fromJson(json['name']).ko : '',
      description: json['description'] != null
          ? Language.fromJson(json['description']).ko
          : '',
      noticeInformation: json['notice_information'],
      detailContents: json['detail_contents'],
      data: json['data'] != null ? ImageData.fromJson(json['data']) : null,
      store: json['store'] ?? {},
      options: json['options'] != null
          ? List<ProductOption>.from(
              json['options'].map((e) => ProductOption.fromJson(e)))
          : [],
      delivery: DeliveryDetailInfo.fromJson(json['delivery']));
}

class DeliveryDetailInfo {
  dynamic id;
  dynamic globalId;
  String description;
  int price;
  bool isDiscount;
  String discountType;
  int discountPrice;
  int discountAmount;
  int discountPercentage;
  int purchasableQuantityMin;
  int purchasableQuantityMax;
  bool isPurchasable;
  bool isManageStock;
  bool isTemporarySoldOut;
  int stockQuantity;
  int safetyInventory;

  DeliveryDetailInfo({
    required this.id,
    required this.globalId,
    required this.description,
    required this.price,
    required this.isDiscount,
    required this.discountType,
    required this.discountPrice,
    required this.discountAmount,
    required this.discountPercentage,
    required this.purchasableQuantityMin,
    required this.purchasableQuantityMax,
    required this.isPurchasable,
    required this.isManageStock,
    required this.isTemporarySoldOut,
    required this.stockQuantity,
    required this.safetyInventory,
  });
  factory DeliveryDetailInfo.fromJson(Map<String, dynamic> json) =>
      DeliveryDetailInfo(
        id: json['id'],
        globalId: json['global_id'],
        description: json['description'] != null
            ? Language.fromJson(json['description']).ko
            : '',
        price: json['price'],
        isDiscount: json['is_discount'],
        discountType: json['discount_type'],
        discountPrice: json['discount_price'],
        discountAmount: json['discount_amount'],
        discountPercentage: json['discount_percentage'],
        purchasableQuantityMin: json['purchasable_quantity_min'],
        purchasableQuantityMax: json['purchasable_quantity_max'],
        isPurchasable: json['is_purchasable'],
        isManageStock: json['is_manage_stock'],
        isTemporarySoldOut: json['is_temporary_sold_out'],
        stockQuantity: json['stock_quantity'],
        safetyInventory: json['safety_inventory'],
      );
}
