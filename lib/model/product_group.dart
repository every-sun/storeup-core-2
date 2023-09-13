import 'package:user_core2/model/language.dart';

/* 장보기 카테고리 */
class ProductGroupResponse {
  bool status;
  String message;
  List<ProductGroup> data;
  ProductGroupResponse(
      {required this.status, required this.message, required this.data});
  factory ProductGroupResponse.fromJson(Map<String, dynamic> json) =>
      ProductGroupResponse(
          status: json['status'],
          message: json['message'] ?? '',
          data: json['data'] != null
              ? List<ProductGroup>.from(
                  json['data'].map((x) => ProductGroup.fromJson(x)))
              : []);
}

class ProductGroup {
  dynamic id;
  String name;
  String description;
  dynamic productGroupId;
  String? mediaUrl;
  List<ProductGroup> childrenGroups;
  int productsCount;

  ProductGroup(
      {required this.id,
      required this.name,
      required this.description,
      required this.productGroupId,
      required this.mediaUrl,
      required this.childrenGroups,
      required this.productsCount});
  factory ProductGroup.fromJson(Map<String, dynamic> json) => ProductGroup(
      id: json['id'],
      name: Language.fromJson(json['name']).ko,
      description: Language.fromJson(json['description']).ko,
      productGroupId: json['product_group_id'],
      mediaUrl: (json['media'] != null && json['media'].isNotEmpty)
          ? json['media'][0]['original_url']
          : null,
      childrenGroups: json['children_groups'] != null
          ? List<ProductGroup>.from(
              json['children_groups'].map((x) => ProductGroup.fromJson(x)))
          : [],
      productsCount: json['products_count'] ?? 0);
}

/* -----장보기 카테고리---- */
