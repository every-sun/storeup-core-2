class StoreResponse {
  bool status;
  String message;
  StoreResponseData? data;
  StoreResponse(
      {required this.status, required this.message, required this.data});
  factory StoreResponse.fromJson(Map<String, dynamic> json) => StoreResponse(
      status: json['status'],
      message: json['message'] ?? '',
      data: json['data'] != null
          ? StoreResponseData.fromJson(json['data'])
          : null);
}

class StoreResponseData {
  List<Store> data;
  int total;
  StoreResponseData({required this.data, required this.total});
  factory StoreResponseData.fromJson(Map<String, dynamic> json) =>
      StoreResponseData(
          data: json['data'] != null
              ? List<Store>.from(json['data'].map((x) => Store.fromJson(x)))
              : [],
          total: json['total'] ?? 0);
}

class Store {
  dynamic id;
  dynamic tenantId;
  String ownerName;
  String ownerContact;
  bool isOpen;
  bool isDelivery;
  bool isNow;
  bool isOnline;
  String storeName;
  String storeContact;
  String storeAddress;
  String registrationNo;
  String description;
  String texType;
  dynamic openingHours;
  dynamic regularHoliday;
  String? mediaUrl;
  dynamic addressData;
  dynamic bankAccountData;
  int reviewsCount;

  Store(
      {required this.id,
      required this.tenantId,
      required this.ownerName,
      required this.ownerContact,
      required this.isOpen,
      required this.isDelivery,
      required this.isNow,
      required this.isOnline,
      required this.storeName,
      required this.storeContact,
      required this.storeAddress,
      required this.registrationNo,
      required this.description,
      required this.texType,
      required this.openingHours,
      required this.regularHoliday,
      required this.mediaUrl,
      required this.addressData,
      required this.bankAccountData,
      required this.reviewsCount});
  factory Store.fromJson(Map<String, dynamic> json) => Store(
      id: json['id'],
      tenantId: json['tenant_id'],
      ownerName: json['owner_name'],
      ownerContact: json['owner_contact'],
      isOpen: json['is_open'],
      isDelivery: json['is_delivery'],
      isNow: json['is_now'],
      isOnline: json['is_online'],
      storeName: json['store_name'] ?? '',
      storeContact: json['store_contact'] ?? '',
      storeAddress: json['store_address'] ?? '',
      registrationNo: json['registration_no'] ?? '',
      description: json['description'] ?? '',
      texType: json['tex_type'] ?? '',
      openingHours: json['opening_hours'],
      regularHoliday: json['regular_holiday'],
      mediaUrl: (json['data'] != null && json['data']['store_image'] != null)
          ? json['data']['store_image'].values.toList()[0]
          : null,
      addressData: json['address_data'],
      bankAccountData: json['bank_account_data'],
      reviewsCount: json['reviews_count'] ?? 0);
}
