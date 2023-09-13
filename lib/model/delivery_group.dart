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
  String? mediaUrl;

  DeliveryGroup({
    required this.id,
    required this.name,
    required this.description,
    required this.mediaUrl,
  });
  factory DeliveryGroup.fromJson(Map<String, dynamic> json) => DeliveryGroup(
        id: json['id'],
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        mediaUrl: (json['media'] != null && json['media'].isNotEmpty)
            ? json['media'][0]['original_url']
            : null,
      );
}
/* -----배달상점 카테고리---- */
