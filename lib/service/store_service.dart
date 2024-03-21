import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/store.dart';
import 'package:user_core2/service/service.dart';

class StoreServices {
  static Future<StoreResponse> getStores(brandId, page) async {
    var response = await http.get(
        Uri.parse('${ServiceAPI.baseUrl}/brands/$brandId/stores?page=$page'),
        headers: ServiceAPI.headerInfo);
    return StoreResponse.fromJson(jsonDecode(response.body));
  }

  static Future<Store> getStore(brandId, tenantId) async {
    var response = await http.get(
        Uri.parse('${ServiceAPI.baseUrl}/brands/$brandId/stores/$tenantId'),
        headers: ServiceAPI.headerInfo);
    return Store.fromJson(jsonDecode(response.body)['data']);
  }

  static Future<StoreResponse> getStoresBySearch(brandId, keyWord, page) async {
    var response = await http.get(
        Uri.parse(
            '${ServiceAPI.baseUrl}/brands/$brandId/stores/search?key_word=$keyWord&page=$page'),
        headers: ServiceAPI.headerInfo);
    return StoreResponse.fromJson(jsonDecode(response.body));
  }
}
