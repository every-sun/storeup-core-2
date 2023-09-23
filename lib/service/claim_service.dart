import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/claim.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/service/service.dart';

class ClaimServices {
  // 환불받을 금액
  static Future<RefundResponse> getRefundData(
      orderId, isCancelAll, claimType, reasonType, itemId) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI().baseUrl}/claims/calculations?order_id=$orderId&is_cancel_all=$isCancelAll&claim_type=$claimType&reason_type=$reasonType&item_id=$itemId'),
      headers: ServiceAPI().headerInfo,
    );
    return RefundResponse.fromJson(jsonDecode(response.body));
  }

  static Future<BasicResponse> requestClaim(ClaimRequestBody body) async {
    var response = await http.post(Uri.parse('${ServiceAPI().baseUrl}/claims'),
        headers: ServiceAPI().headerInfo, body: jsonEncode(body.toJson()));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  // 취소, 교환, 반품 신청 철회
  static Future<BasicResponse> cancelClaim(id) async {
    var response = await http.put(
        Uri.parse('${ServiceAPI().baseUrl}/claims/$id'),
        headers: ServiceAPI().headerInfo,
        body: jsonEncode({'is_undone': true}));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<ClaimResponse> getClaims(
      customerId, String from, String to, int page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI().baseUrl}/customers/$customerId/claims?from=$from&to=$to&page=$page'),
      headers: ServiceAPI().headerInfo,
    );
    return ClaimResponse.fromJson(jsonDecode(response.body));
  }

  static Future<Claim> getClaim(customerId, dynamic id) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI().baseUrl}/customers/$customerId/claims/$id'),
      headers: ServiceAPI().headerInfo,
    );
    return Claim.fromJson(jsonDecode(response.body)['data']);
  }
}
