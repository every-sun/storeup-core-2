import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/assets.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/service/service.dart';

class AssetsServices {
  static Future<CouponResponse> getCoupons(
      customerId, bool available, int page) async {
    var response = await http.get(
        Uri.parse(
            '${ServiceAPI.baseUrl}/customers/$customerId/coupons?available=$available&page=$page'),
        headers: ServiceAPI.headerInfo);

    return CouponResponse.fromJson(jsonDecode(response.body));
  }

  static Future<int> getCouponTotal(customerId) async {
    var response = await http.get(
        Uri.parse('${ServiceAPI.baseUrl}/customers/$customerId/coupons/count'),
        headers: ServiceAPI.headerInfo);
    return jsonDecode(response.body)['data'] ?? 0;
  }

  static Future<List<Coupon>> getCouponsForOrder(customerId) async {
    var response = await http.get(
        Uri.parse('${ServiceAPI.baseUrl}/customers/$customerId/coupons/orders'),
        headers: ServiceAPI.headerInfo);
    return jsonDecode(response.body)['data'] == null
        ? []
        : List<Coupon>.from(
            jsonDecode(response.body)['data'].map((x) => Coupon.fromJson(x)));
  }

  static Future<BasicResponse> issueCoupon(customerId, couponNo) async {
    var response = await http.post(
        Uri.parse('${ServiceAPI.baseUrl}/customers/$customerId/coupons'),
        headers: ServiceAPI.headerInfo,
        body: jsonEncode({'coupon_no': couponNo}));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<PointResponse> getPointHistory(customerId, type, page) async {
    // type: A, I(적립), D(감소), E(소멸)
    var response = await http.get(
        Uri.parse(
            '${ServiceAPI.baseUrl}/customers/$customerId/point/history?type=$type&page=$page'),
        headers: ServiceAPI.headerInfo);
    return PointResponse.fromJson(jsonDecode(response.body));
  }

  static Future<int> getPointTotal(customerId) async {
    var response = await http.get(
        Uri.parse('${ServiceAPI.baseUrl}/customers/$customerId/point'),
        headers: ServiceAPI.headerInfo);
    return jsonDecode(response.body)['data'] != null
        ? jsonDecode(response.body)['data']['total_point']
        : 0;
  }
}
