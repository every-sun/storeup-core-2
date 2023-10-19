import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/brand.dart';
import 'package:user_core2/model/popup.dart';
import 'package:user_core2/service/service.dart';

class BrandServices {
  /* 배송비 정보 */
  static Future<ShippingFeeResponse> getShippingFee(dynamic brandId) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI().baseUrl}/brands/$brandId/config/shippingFee'),
      headers: ServiceAPI().headerInfo,
    );
    return ShippingFeeResponse.fromJson(jsonDecode(response.body));
  }

  /* 배달비 정보 */
  static Future<ShippingFeeResponse> getDeliveryFee(dynamic brandId) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI().baseUrl}/brands/$brandId/config/deliveryFee'),
      headers: ServiceAPI().headerInfo,
    );
    return ShippingFeeResponse.fromJson(jsonDecode(response.body));
  }

  /* 택배 정보 */
  static Future<CarrierResponse> getCarrier(dynamic brandId) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI().baseUrl}/brands/$brandId/config/carrier'),
      headers: ServiceAPI().headerInfo,
    );
    return CarrierResponse.fromJson(jsonDecode(response.body));
  }

  static Future<List<Popup>> getPopupsOrBanner(dynamic brandId, type) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI().baseUrl}/brands/$brandId/mall/$type'),
      headers: ServiceAPI().headerInfo,
    );
    return jsonDecode(response.body)['data'] != null
        ? List<Popup>.from(
            jsonDecode(response.body)['data'].map(((x) => Popup.fromJson(x))))
        : [];
  }

  /* 판매자 정보 */
  static Future<BrandConfigResponse> getBrandConfig(dynamic brandId) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI().baseUrl}/brands/$brandId/config'),
      headers: ServiceAPI().headerInfo,
    );
    return BrandConfigResponse.fromJson(jsonDecode(response.body));
  }
}
