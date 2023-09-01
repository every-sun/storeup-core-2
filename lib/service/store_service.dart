import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/store.dart';
import 'package:user_core2/service/service.dart';

class StoreServices2 {
  static Future<StoreResponse> getStores(brandId) async {
    var response = await http.get(
        Uri.parse('${ServiceAPI().baseUrl}/brands/$brandId/stores'),
        headers: ServiceAPI().headerInfo);
    return StoreResponse.fromJson(jsonDecode(response.body));
  }
}
