import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/shipping_address.dart';
import 'package:user_core2/service/service.dart';

class ShippingAddressServices2 {
  static Future<List<ShippingAddress>> getShippingAddresses(
      customerId, page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI().baseUrl}/address?customer_id=$customerId&page=$page'),
      headers: ServiceAPI().headerInfo,
    );
    return List<ShippingAddress>.from(jsonDecode(response.body)['data']
        .map((x) => ShippingAddress.fromJson(x)));
  }
}
