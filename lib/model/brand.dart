/* 배송비 정보 */
class ShippingFeeResponse {
  bool status;
  String message;
  ShippingFeeResponseData? data;
  ShippingFeeResponse(
      {required this.status, required this.message, required this.data});
  factory ShippingFeeResponse.fromJson(Map<String, dynamic> json) =>
      ShippingFeeResponse(
          status: json['status'],
          message: json['message'] ?? '',
          data: json['data'] != null
              ? ShippingFeeResponseData.fromJson(json['data'])
              : null);
}

class ShippingFeeResponseData {
  dynamic id;
  bool isDefault;
  String name;
  String conditionType;
  int condition;
  int conditionFee;
  int defaultFee;
  dynamic shippingPeriod;
  ShippingFeeResponseData(
      {required this.id,
      required this.isDefault,
      required this.name,
      required this.conditionType,
      required this.condition,
      required this.conditionFee,
      required this.defaultFee,
      required this.shippingPeriod});
  factory ShippingFeeResponseData.fromJson(Map<String, dynamic> json) =>
      ShippingFeeResponseData(
          id: json['id'],
          isDefault: json['is_default'],
          name: json['name'],
          conditionType: json['condition_type'],
          condition: json['condition'],
          conditionFee: json['condition_fee'],
          defaultFee: json['default_fee'],
          shippingPeriod: json['shipping_period']);
}

/* 택배 정보 */
class CarrierResponse {
  bool status;
  String message;
  CarrierResponseData? data;
  CarrierResponse(
      {required this.status, required this.message, required this.data});
  factory CarrierResponse.fromJson(Map<String, dynamic> json) =>
      CarrierResponse(
          status: json['status'],
          message: json['message'] ?? '',
          data: json['data'] != null
              ? CarrierResponseData.fromJson(json['data'])
              : null);
}

class CarrierResponseData {
  dynamic id;
  bool isDefault;
  String name;
  String code;
  String contact;
  String url;
  int defaultFee;
  dynamic shippingPeriod;
  CarrierResponseData(
      {required this.id,
      required this.isDefault,
      required this.name,
      required this.code,
      required this.contact,
      required this.url,
      required this.defaultFee});
  factory CarrierResponseData.fromJson(Map<String, dynamic> json) =>
      CarrierResponseData(
          id: json['id'],
          isDefault: json['is_default'],
          name: json['name'] ?? '',
          code: json['code'] ?? '',
          contact: json['contact'] ?? '',
          url: json['url'],
          defaultFee: json['default_fee']);
}

/* 판매자 정보 */
class BrandConfigResponse {
  bool status;
  String message;
  Config? data;
  BrandConfigResponse(
      {required this.status, required this.message, required this.data});
  factory BrandConfigResponse.fromJson(Map<String, dynamic> json) =>
      BrandConfigResponse(
          status: json['status'],
          message: json['message'] ?? '',
          data: json['data'] != null ? Config.fromJson(json['data']) : null);
}

class Config {
  dynamic id;
  String brandName;
  String contact;
  String representation;
  String mailOrderSalesNo;
  String informationProtectionCharge;
  String domain;
  String address1;
  String address2;
  String zipcode;
  int brandCalculateShippingFee;
  Config(
      {required this.id,
      required this.brandName,
      required this.contact,
      required this.representation,
      required this.mailOrderSalesNo,
      required this.informationProtectionCharge,
      required this.domain,
      required this.address1,
      required this.address2,
      required this.zipcode,
      required this.brandCalculateShippingFee});
  factory Config.fromJson(Map<String, dynamic> json) => Config(
      id: json['id'],
      brandName: json['brand_name'] ?? '',
      contact: json['contact'] ?? '',
      representation: json['representation'] ?? '',
      mailOrderSalesNo: json['mail_order_sales_no'] ?? '',
      informationProtectionCharge: json['information_protection_charge'] ?? '',
      domain: json['domain'] ?? '',
      address1: json['address1'] ?? '',
      address2: json['address2'] ?? '',
      zipcode: json['zipcode'] ?? '',
      brandCalculateShippingFee: json['brand_calculate_shipping_fee']);
}
