import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/claim.dart';
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
}
