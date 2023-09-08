import 'package:user_core2/model/language.dart';

/* 배달상점 카테고리 */
class DeliveryGroupResponse {
  bool status;
  String message;
  List<DeliveryGroup> data;
  DeliveryGroupResponse(
      {required this.status, required this.message, required this.data});
  factory DeliveryGroupResponse.fromJson(Map<String, dynamic> json) =>
      DeliveryGroupResponse(
          status: json['status'],
          message: json['message'] ?? '',
          data: json['data'] != null
              ? List<DeliveryGroup>.from(
                  json['data'].map((x) => DeliveryGroup.fromJson(x)))
              : []);
}

class DeliveryGroup {
  dynamic id;
  String name;
  String description;
  List<Map<dynamic, dynamic>> media;

  DeliveryGroup({
    required this.id,
    required this.name,
    required this.description,
    required this.media,
  });
  factory DeliveryGroup.fromJson(Map<String, dynamic> json) => DeliveryGroup(
        id: json['id'],
        name: Language.fromJson(json['name']).ko,
        description: Language.fromJson(json['description']).ko,
        media: json['media'],
      );
}
/* -----배달상점 카테고리---- */
