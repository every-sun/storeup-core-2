/* 배송비 정보 */
class ShippingFeeResponse {
  bool status;
  String message;
  ShippingFeeResponseData data;
  ShippingFeeResponse(
      {required this.status, required this.message, required this.data});
  factory ShippingFeeResponse.fromJson(Map<String, dynamic> json) =>
      ShippingFeeResponse(
          status: json['status'],
          message: json['message'] ?? '',
          data: ShippingFeeResponseData.fromJson(json['data']));
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
  CarrierResponseData data;
  CarrierResponse(
      {required this.status, required this.message, required this.data});
  factory CarrierResponse.fromJson(Map<String, dynamic> json) =>
      CarrierResponse(
          status: json['status'],
          message: json['message'] ?? '',
          data: CarrierResponseData.fromJson(json['data']));
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
          name: json['name'],
          code: json['code'],
          contact: json['contact'],
          url: json['url'],
          defaultFee: json['default_fee']);
}
