import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/inquiry.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/service/service.dart';

class InquiryServices {
  static Future<BasicResponse> deleteInquiry(customerId, dynamic id) async {
    var response = await http.delete(
      Uri.parse(
          '${ServiceAPI().baseUrl}/customers/$customerId/inquiries/delete/$id'),
      headers: ServiceAPI().headerInfo,
    );
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
      customerId, type, int page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI().baseUrl}/customers/$customerId/inquiries?type=$type&page=$page'),
      headers: ServiceAPI().headerInfo,
    );
    return InquiryResponse.fromJson(jsonDecode(response.body));
  }
}
