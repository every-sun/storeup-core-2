import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/brand.dart';
import 'package:user_core2/service/service.dart';

class BrandServices {
  /* 배송비 정보 */
  static Future<ShippingFeeResponse> getShippingFee(dynamic brandId) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI().baseUrl}/brands/$brandId/config/shippingFee'),
      headers: ServiceAPI().headerInfo,
    );
    print('배송비 정보: ${jsonDecode(response.body)}');
    return ShippingFeeResponse.fromJson(jsonDecode(response.body));
  }

  /* 택배 정보 */
  static Future<CarrierResponse> getCarrier(dynamic brandId) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI().baseUrl}/brands/$brandId/config/carrier'),
      headers: ServiceAPI().headerInfo,
    );
    print('택배 정보: ${jsonDecode(response.body)}');
    return CarrierResponse.fromJson(jsonDecode(response.body));
  }
}
