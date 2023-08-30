import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/language.dart';
import 'package:user_core2/model/shipping_address.dart';
import 'package:user_core2/service/service.dart';

class ShippingAddressServices2 {
  static Future<ShippingAddressResponse> getShippingAddresses(
      customerId, page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI().baseUrl}/address?customer_id=$customerId&page=$page'),
      headers: ServiceAPI().headerInfo,
    );
    print(jsonDecode(response.body));
    return ShippingAddressResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> storeShippingAddress(
      ShippingAddressRequestBody body) async {
    var response = await http.post(
      Uri.parse('${ServiceAPI().baseUrl}/address/store'),
      headers: ServiceAPI().headerInfo,
      body: jsonEncode(body.toJson()),
    );
    print('배송지 저장: ${jsonEncode(body.toJson())}');
    print(jsonDecode(response.body));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> editShippingAddress(
      addressId, ShippingAddressRequestBody body) async {
    var response = await http.put(
      Uri.parse('${ServiceAPI().baseUrl}/address/edit/$addressId'),
      headers: ServiceAPI().headerInfo,
      body: jsonEncode(body.toJson()),
    );
    print(jsonDecode(response.body));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> deleteShippingAddress(addressId) async {
    var response = await http.delete(
        Uri.parse('${ServiceAPI().baseUrl}/address/delete/$addressId'),
        headers: ServiceAPI().headerInfo);
    print(jsonDecode(response.body));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> setDefaultShippingAddress(addressId) async {
    var response = await http.put(
      Uri.parse('${ServiceAPI().baseUrl}/address/default/edit/$addressId'),
      headers: ServiceAPI().headerInfo,
    );
    print(jsonDecode(response.body));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<DefaultShippingAddressResponse> getDefaultShippingAddress(
      customerId) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI().baseUrl}/address/default?customer_id=$customerId'),
      headers: ServiceAPI().headerInfo,
    );
    print(jsonDecode(response.body));
    return DefaultShippingAddressResponse.fromJson(jsonDecode(response.body));
  }
}
