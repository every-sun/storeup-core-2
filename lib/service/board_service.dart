import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user_core2/model/board.dart';
import 'package:user_core2/service/service.dart';

class BoardServices {
  static Future<BoardResponse> getBoards(dynamic brandId) async {
    var response = await http.get(
      Uri.parse('${ServiceAPI.baseUrl}/brands/$brandId/boards'),
      headers: ServiceAPI.headerInfo,
    );
    return BoardResponse.fromJson(jsonDecode(response.body));
  }

  static Future<Board?> getBoard(dynamic brandId, String type) async {
    // type=E, N
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI.baseUrl}/brands/$brandId/boards/default?type=$type'),
      headers: ServiceAPI.headerInfo,
    );
    return jsonDecode(response.body)['data'] != null
        ? Board.fromJson(jsonDecode(response.body)['data'])
        : null;
  }

  //-------------------------------------------------------------------------------------------

  static Future<PostResponse> getPosts(
    dynamic brandId,
    dynamic boardId,
    int page,
  ) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI.baseUrl}/brands/$brandId/boards/$boardId/posts?page=$page'),
      headers: ServiceAPI.headerInfo,
    );
    return PostResponse.fromJson(jsonDecode(response.body));
  }

  static Future<List<Post>> getExpiredPosts(
    dynamic brandId,
    dynamic boardId,
    int page,
  ) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI.baseUrl}/brands/$brandId/boards/$boardId/posts/expired?page=$page'),
      headers: ServiceAPI.headerInfo,
    );
    return List<Post>.from(
        jsonDecode(response.body)['data']['data'].map((x) => Post.fromJson(x)));
  }

  static Future<PostDetail> getPostDetail(
      dynamic brandId, dynamic boardId, dynamic postId) async {
    var response = await http.get(
      Uri.parse(
          '${ServiceAPI.baseUrl}/brands/$brandId/boards/$boardId/posts/$postId'),
      headers: ServiceAPI.headerInfo,
    );
    return PostDetail.fromJson(jsonDecode(response.body)['data']);
  }
}
