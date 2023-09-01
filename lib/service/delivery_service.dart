import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/juso.dart';

class DeliveryServices2 {
  static Future<List<Juso>?> getAddress(keyword, page) async {
    var response = await http.get(Uri.parse(
        'https://www.juso.go.kr/addrlink/addrLinkApi.do?confmKey=U01TX0FVVEgyMDIzMDEwMjIzMTkxNzExMzM5Mzk=&keyword=$keyword&currentPage=$page&countPerPage=20&resultType=json'));
    if (response.statusCode == 200) {
      return DeliveryAddressResponse.fromJson(jsonDecode(response.body))
          .results
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
}
