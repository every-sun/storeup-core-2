class DeliveryAddressResponse {
  bool status;
  String message;
  DeliveryAddress? data;
  DeliveryAddressResponse(
      {required this.status, required this.message, required this.data});
  factory DeliveryAddressResponse.fromJson(Map<String, dynamic> json) =>
      DeliveryAddressResponse(
          status: json['status'],
          message: json['message'] ?? '',
          data: json['data'] != null
              ? DeliveryAddress.fromJson(json['data'])
              : null);
}

class DeliveryAddress {
  dynamic id;
  String newAddress;
  String oldAddress;
  String gpsLat;
  String gpsLon;
  String detailAddress;
  String region;
  int regionChargingFee;
  bool isAvailableRegion;
  DeliveryAddress({
    required this.id,
    required this.newAddress,
    required this.oldAddress,
    required this.detailAddress,
    required this.region,
    required this.gpsLat,
    required this.gpsLon,
    required this.regionChargingFee,
    required this.isAvailableRegion,
  });
  factory DeliveryAddress.fromJson(Map<String, dynamic> json) =>
      DeliveryAddress(
        id: json['id'],
        newAddress: json['new_address'],
        oldAddress: json['old_address'],
        detailAddress: json['detail_address'],
        region: json['region'],
        gpsLat: json['gps_lat'] ?? '',
        gpsLon: json['gps_lon'] ?? '',
        regionChargingFee: json['region_charging_fee'],
        isAvailableRegion: json['is_available_region'],
      );
}
