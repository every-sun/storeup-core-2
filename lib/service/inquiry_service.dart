import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/inquiry.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/service/service.dart';

class InquiryServices {
  static Future<BasicResponse> deleteInquiry(customerId, dynamic id) async {
    var response = await http.delete(
      Uri.parse(
          '${ServiceAPI().baseUrl}/customers/$customerId/inquiry/delete/$id'),
      headers: ServiceAPI().headerInfo,
    );
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> editInquiry(
      customerId, dynamic id, contents) async {
    var response = await http.put(
        Uri.parse(
            '${ServiceAPI().baseUrl}/customers/$customerId/inquiry/edit/$id'),
        headers: ServiceAPI().headerInfo,
        body: jsonEncode({'contents': contents}));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<InquiryResponse> getInquiriesByProduct(
      productId, int page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI().baseUrl}/products/$productId/inquiries?page=$page'),
      headers: ServiceAPI().headerInfo,
    );
    return InquiryResponse.fromJson(jsonDecode(response.body));
  }

  static Future<InquiryResponse> getInquiriesByCustomerId(
      customerId, int page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI().baseUrl}/customers/$customerId/inquiries?page=$page'),
      headers: ServiceAPI().headerInfo,
    );
    return InquiryResponse.fromJson(jsonDecode(response.body));
  }
}
