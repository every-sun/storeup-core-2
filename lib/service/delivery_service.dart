import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/delivery_address.dart';
import 'package:user_core2/model/delivery_group.dart';
import 'package:user_core2/model/delivery_product.dart';
import 'package:user_core2/model/juso.dart';
import 'package:user_core2/model/language.dart';
import 'package:user_core2/model/order.dart';
import 'package:user_core2/model/store.dart';
import 'package:user_core2/service/service.dart';

class DeliveryServices {
  static Future<List<Juso>?> getAddress(keyword, page) async {
    var response = await http.get(Uri.parse(
        'https://www.juso.go.kr/addrlink/addrLinkApi.do?confmKey=U01TX0FVVEgyMDIzMDEwMjIzMTkxNzExMzM5Mzk=&keyword=$keyword&currentPage=$page&countPerPage=20&resultType=json'));
    if (response.statusCode == 200) {
      return JusoResults.fromJson(jsonDecode(response.body)['results'])
          .jusoList;
    } else {
      return null;
    }
  }

  static Future<Map?> getAddressLocation(loadAddress) async {
    var response = await http.get(
        Uri.parse(
            'https://dapi.kakao.com/v2/local/search/address.json?query=$loadAddress&analyze_type=exact'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'KakaoAK e9f6e56e3e82a1dc740b404644b311ad'
        });
    if (response.statusCode == 200) {
      if (LocationResponse.fromJson(jsonDecode(response.body))
              .documents
              .address !=
          null) {
        return LocationResponse.fromJson(jsonDecode(response.body))
            .documents
            .address;
      } else {
        return null;
      }
    } else {
      return null;
    }
  }

  static Future<AddressByLocationDocument?> getAddressByLocation(
      longitude, latitude) async {
    var response = await http.get(
        Uri.parse(
            'https://dapi.kakao.com/v2/local/geo/coord2address?x=$longitude&y=$latitude'),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'KakaoAK e9f6e56e3e82a1dc740b404644b311ad'
        });
    if (response.statusCode == 200) {
      return AddressByLocationResponse.fromJson(jsonDecode(response.body))
          .documents;
    } else {
      return null;
    }
  }

  /* 배달지 저장, 조회 */
  static Future<BasicResponse> saveDeliveryAddress(
      customerId, newAddress, oldAddress, detailAddress) async {
    var response = await http.post(
        Uri.parse(
            '${ServiceAPI.baseUrl}/customers/$customerId/delivery/address'),
        headers: ServiceAPI.headerInfo,
        body: jsonEncode({
          'new_address': newAddress,
          'old_address': oldAddress,
          'detail_address': detailAddress
        }));
    return BasicResponse.fromJson(jsonDecode(response.body));
  }

  static Future<DeliveryAddressResponse> getDeliveryAddressByCustomerId(
      customerId) async {
    var response = await http.get(
        Uri.parse(
            '${ServiceAPI.baseUrl}/customers/$customerId/delivery/address'),
        headers: ServiceAPI.headerInfo);
    return DeliveryAddressResponse.fromJson(jsonDecode(response.body));
  }

  /* 배달 카테고리 조회 */
  static Future<DeliveryGroupResponse> getDeliveryGroups(brandId) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI.baseUrl}/brands/$brandId/deliveries/groups'),
      headers: ServiceAPI.headerInfo,
    );
    return DeliveryGroupResponse.fromJson(jsonDecode(response.body));
  }

  /* 배달 상점 불러오기 */
  static Future<StoreResponse> getDeliveryStoresByGroup(
      brandId, groupId, page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI.baseUrl}/brands/$brandId/deliveries/groups/$groupId?page=$page'),
      headers: ServiceAPI.headerInfo,
    );
    return StoreResponse.fromJson(jsonDecode(response.body));
  }

  /* 배달상점 검색 */
  static Future<StoreResponse> getDeliveryStoresBySearch(
      brandId, keyword, page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI.baseUrl}/brands/$brandId/deliveries/search?keyword=$keyword&page=$page'),
      headers: ServiceAPI.headerInfo,
    );
    return StoreResponse.fromJson(jsonDecode(response.body));
  }

  /* 메인페이지에서 배달 상점 랜덤으로 불러오기 */
  static Future<StoreResponse> getDeliveryStoresRandom(brandId, page) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI.baseUrl}/brands/$brandId/deliveries?page=$page'),
      headers: ServiceAPI.headerInfo,
    );
    return StoreResponse.fromJson(jsonDecode(response.body));
  }

  /* 배달상품 불러오기(배달상점 상세페이지) */
  static Future<DeliveryProductsByStoreResponse> getDeliveryProductsByStore(
      brandId, tenantId) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI.baseUrl}/brands/$brandId/stores/$tenantId/deliveries/categories'),
      headers: ServiceAPI.headerInfo,
    );
    return DeliveryProductsByStoreResponse.fromJson(jsonDecode(response.body));
  }

  /* 배달상품 단일조회 */
  static Future<DeliveryDetail> getDeliveryProduct(globalId) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI.baseUrl}/products/global/$globalId?type=D'),
      headers: ServiceAPI.headerInfo,
    );
    return DeliveryDetail.fromJson(jsonDecode(response.body)['data']);
  }

  static Future<List<Order>?> getOrders(
      dynamic customerId, String type, int? page) async {
    // close, progress
    String url =
        '${ServiceAPI.baseUrl}/orders/customer/$customerId/delivery/$type';
    if (type == 'close') {
      url += '?page=$page';
    }
    var response = await http.get(
      Uri.parse(url),
      headers: ServiceAPI.headerInfo,
    );
    if (jsonDecode(response.body)['data'] == null) {
      return null;
    } else {
      if (type == 'close') {
        if (jsonDecode(response.body)['data']['data'] == null) {
          return null;
        } else {
          return List<Order>.from(jsonDecode(response.body)['data']['data']
              .map((x) => Order.fromJson(x)));
        }
      } else {
        return List<Order>.from(
            jsonDecode(response.body)['data'].map((x) => Order.fromJson(x)));
      }
    }
  }
}
