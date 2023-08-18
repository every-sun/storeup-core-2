class ShippingAddress {
  dynamic id;
  String alias;
  String zipcode;
  String address1;
  String address2;
  String gpsLat;
  String gpsLon;
  String receiverName;
  String receiverContact;
  dynamic regionChargingFee;
  bool isDefaultAddress;
  bool isAvailableRegion;
  ShippingAddress(
      {required this.id,
      required this.alias,
      required this.zipcode,
      required this.address1,
      required this.address2,
      required this.gpsLat,
      required this.gpsLon,
      required this.receiverName,
      required this.receiverContact,
      required this.regionChargingFee,
      required this.isAvailableRegion,
      required this.isDefaultAddress});
  factory ShippingAddress.fromJson(Map<String, dynamic> json) =>
      ShippingAddress(
          id: json['id'],
          alias: json['alias'],
          zipcode: json['zipcode'],
          address1: json['address1'],
          address2: json['address2'],
          gpsLat: json['gps_lat'],
          gpsLon: json['gps_lon'],
          receiverName: json['receiver_name'],
          receiverContact: json['receiver_contact'],
          regionChargingFee: json['region_charging_fee'],
          isAvailableRegion: json['is_available_region'] == 1,
          isDefaultAddress: json['is_default_address'] == 1);
}

class ShippingAddressRequestBody {
  String? customerId; // 배송지 추가시 null 아님/수정시 null
  String alias;
  String zipcode;
  String address1;
  String address2;
  String receiverName;
  String receiverContact;
  bool isDefaultAddress;
  ShippingAddressRequestBody(
      {this.customerId,
      required this.alias,
      required this.zipcode,
      required this.address1,
      required this.address2,
      required this.receiverName,
      required this.receiverContact,
      required this.isDefaultAddress});
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = Map<String, dynamic>();
    if (customerId != null) {
      body['customer_id'] = customerId;
    }
    body['alias'] = alias;
    body['zipcode'] = zipcode;
    body['address1'] = address1;
    body['address2'] = address2;
    body['receiver_name'] = receiverName;
    body['receiver_contact'] = receiverContact;
    body['is_default_address'] = isDefaultAddress;
    return body;
  }
}
