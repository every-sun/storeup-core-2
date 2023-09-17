import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/board.dart';
import 'package:user_core2/service/service.dart';

class BoardServices {
  static Future<BoardResponse> getBoards(dynamic brandId) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI().baseUrl}/brands/$brandId/boards'),
      headers: ServiceAPI().headerInfo,
    );
    return BoardResponse.fromJson(jsonDecode(response.body));
  }

  static Future<PostResponse> getPosts(
      dynamic brandId, dynamic boardId, int page) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI().baseUrl}/brands/$brandId/boards/$boardId/posts?page=$page'),
      headers: ServiceAPI().headerInfo,
    );
    return PostResponse.fromJson(jsonDecode(response.body));
  }

  static Future<PostDetail> getPostDetail(
      dynamic brandId, dynamic boardId, dynamic postId) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI().baseUrl}/brands/$brandId/boards/$boardId/posts/$postId'),
      headers: ServiceAPI().headerInfo,
    );
    return PostDetail.fromJson(jsonDecode(response.body)['data']);
  }
}
