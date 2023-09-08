import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/delivery_group.dart';
import 'package:user_core2/service/service.dart';

class DeliveryGroupServices {
  static Future<DeliveryGroupResponse> getDeliveryGroups(brandId) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI().baseUrl}/brands/$brandId/groups'),
      headers: ServiceAPI().headerInfo,
    );
    return DeliveryGroupResponse.fromJson(jsonDecode(response.body));
  }
}
