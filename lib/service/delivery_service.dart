import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/delivery_address.dart';
import 'package:user_core2/model/delivery_group.dart';
import 'package:user_core2/model/juso.dart';
import 'package:user_core2/model/language.dart';
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
      print(jsonDecode(response.body));
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
            '${ServiceAPI().baseUrl}/customers/$customerId/delivery/address'),
        headers: ServiceAPI().headerInfo,
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
            '${ServiceAPI().baseUrl}/customers/$customerId/delivery/address'),
        headers: ServiceAPI().headerInfo);
    print(jsonDecode(response.body));
    return DeliveryAddressResponse.fromJson(jsonDecode(response.body));
  }

  /* 배달 카테고리 조회 */
  static Future<DeliveryGroupResponse> getDeliveryGroups(brandId) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI().baseUrl}/brands/$brandId/groups'),
      headers: ServiceAPI().headerInfo,
    );
    return DeliveryGroupResponse.fromJson(jsonDecode(response.body));
  }

  /* 배달 상점 불러오기 */ // TODO 페이지네이션
  static Future<List<Store>> getDeliveryStoresByGroup(brandId, groupId) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI().baseUrl}/brands/$brandId/groups/$groupId'),
      headers: ServiceAPI().headerInfo,
    );
    return List<Store>.from(jsonDecode(response.body)['data']['stores']
        .map((x) => Store.fromJson(x)));
  }
}
