import 'dart:convert';

class DeliveryAddressResponse {
  Results results;

  DeliveryAddressResponse({required this.results});

  factory DeliveryAddressResponse.fromJson(Map<String, dynamic> json) =>
      DeliveryAddressResponse(results: Results.fromJson(json['results']));
}

class Results {
  Common common;
  List<Juso> jusoList;

  Results({required this.common, required this.jusoList});

  factory Results.fromJson(Map<String, dynamic> json) => Results(
      common: Common.fromJson(json['common']),
      jusoList: List<Juso>.from(json['juso'].map((x) => Juso.fromJson(x))));
}

class Common {
  String? errorMessage;
  String? countPerPage;
  String? totalCount;
  String? errorCode;
  String? currentPage;

  Common(
      {this.errorMessage,
      this.countPerPage,
      this.totalCount,
      this.errorCode,
      this.currentPage});

  Common.fromJson(Map<String, dynamic> json) {
    errorMessage = json['errorMessage'];
    countPerPage = json['countPerPage'];
    totalCount = json['totalCount'];
    errorCode = json['errorCode'];
    currentPage = json['currentPage'];
  }
}

class Juso {
  String zipNo;
  String jibunAddr;
  String roadAddrPart1;
  String bdNm;
  String emdNm; //  읍면동명
  String? detail;
  String? gpsLat;
  String? gpsLon;
  // String admCd;  // 행정구역코드

  Juso(
      {required this.zipNo,
      required this.roadAddrPart1,
      required this.jibunAddr,
      required this.bdNm,
      required this.emdNm,
      required this.detail,
      required this.gpsLat,
      required this.gpsLon
      // required this.admCd
      });

  factory Juso.fromJson(Map<String, dynamic> json) => Juso(
      zipNo: json['zipNo'],
      roadAddrPart1: json['roadAddrPart1'],
      jibunAddr: json['jibunAddr'],
      bdNm: json['bdNm'],
      emdNm: json['emdNm'],
      detail: json['detail'],
      gpsLat: json['gpsLat'],
      gpsLon: json['gpsLon']
      // admCd: json['admCd']
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['zipNo'] = zipNo;
    data['roadAddrPart1'] = roadAddrPart1;
    data['jibunAddr'] = jibunAddr;
    data['bdNm'] = bdNm;
    data['emdNm'] = emdNm;
    data['detail'] = detail;
    data['gpsLat'] = gpsLat;
    data['gpsLon'] = gpsLon;
    return data;
  }
}

List<Juso> jusoFromJson(String str) =>
    List<Juso>.from(json.decode(str).map((x) => Juso.fromJson(x)));

class LocationResponse {
  LocationDocuments documents;
  LocationResponse({required this.documents});
  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      LocationResponse(
          documents: List<LocationDocuments>.from(json['documents']
                  .map((x) => LocationDocuments.fromJson(x))).isNotEmpty
              ? List<LocationDocuments>.from(json['documents']
                  .map((x) => LocationDocuments.fromJson(x)))[0]
              : LocationDocuments(address: null));
}

class LocationDocuments {
  Map? address;
  LocationDocuments({required this.address});
  factory LocationDocuments.fromJson(Map<String, dynamic> json) =>
      LocationDocuments(address: json['address']);
}

class AddressByLocationResponse {
  AddressByLocationDocument? documents;
  AddressByLocationResponse({required this.documents});

  factory AddressByLocationResponse.fromJson(Map<String, dynamic> json) {
    return AddressByLocationResponse(
      documents: json['documents'] != null
          ? (List<AddressByLocationDocument>.from(json['documents']
                  .map((x) => AddressByLocationDocument.fromJson(x))).isNotEmpty
              ? List<AddressByLocationDocument>.from(json['documents']
                  .map((x) => AddressByLocationDocument.fromJson(x)))[0]
              : null)
          : null,
    );
  }
}

class AddressByLocationDocument {
  Map? roadAddress;
  Map? address;
  AddressByLocationDocument({required this.roadAddress, required this.address});

  factory AddressByLocationDocument.fromJson(Map<String, dynamic> json) {
    return AddressByLocationDocument(
        roadAddress: json['road_address'], address: json['address']);
  }
}
