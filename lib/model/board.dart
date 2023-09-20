class BoardResponse {
  bool status;
  String message;
  List<Board> data;
  BoardResponse(
      {required this.status, required this.message, required this.data});
  factory BoardResponse.fromJson(Map<String, dynamic> json) => BoardResponse(
      status: json['status'],
      message: json['message'] ?? '',
      data: json['data'] != null
          ? List<Board>.from(json['data'].map((x) => Board.fromJson(x)))
          : []);
}

class Board {
  dynamic id;
  String boardType;
  String title;
  bool isDisplay;
  bool isDefault;
  bool isCentral;
  dynamic data;
  Board(
      {required this.id,
      required this.boardType,
      required this.title,
      required this.isDisplay,
      required this.isDefault,
      required this.isCentral,
      required this.data});
  factory Board.fromJson(Map<String, dynamic> json) => Board(
      id: json['id'],
      boardType: json['board_type'],
      title: json['title'] ?? '',
      isDisplay: json['is_display'],
      isCentral: json['is_central'],
      isDefault: json['is_default'],
      data: json['data']);
}

class PostResponse {
  bool status;
  String message;
  PostResponseData? data;
  PostResponse(
      {required this.status, required this.message, required this.data});
  factory PostResponse.fromJson(Map<String, dynamic> json) => PostResponse(
      status: json['status'],
      message: json['message'] ?? '',
      data: json['data'] != null
          ? PostResponseData.fromJson(json['data'])
          : null);
}

class PostResponseData {
  List<Post> fixedPosts;
  List<Post> posts;
  PostResponseData({
    required this.fixedPosts,
    required this.posts,
  });
  factory PostResponseData.fromJson(Map<String, dynamic> json) =>
      PostResponseData(
        fixedPosts:
            List<Post>.from(json['fixed_posts'].map((x) => Post.fromJson(x))),
        posts:
            List<Post>.from(json['posts']['data'].map((x) => Post.fromJson(x))),
      );
}

class Post {
  dynamic id;
  dynamic boardId;
  String postNo;
  String writer;
  String title;
  DateTime createdAt;
  bool isFixed;
  Post(
      {required this.id,
      required this.boardId,
      required this.postNo,
      required this.writer,
      required this.title,
      required this.createdAt,
      required this.isFixed});
  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'],
        boardId: json['board_id'],
        title: json['title'] ?? '',
        postNo: json['post_no'],
        writer: json['writer'] ?? '',
        isFixed: json['is_fixed'],
        createdAt: DateTime.parse(json['created_at']),
      );
}

class PostDetail {
  dynamic id;
  dynamic boardId;
  dynamic userId;
  String title;
  String postNo;
  String writer;
  String contents;
  bool isExpired;
  bool isFixed;
  bool isHidden;
  bool isLimitedTimePost;
  dynamic data;
  DateTime createdAt;
  PostDetail(
      {required this.id,
      required this.boardId,
      required this.userId,
      required this.title,
      required this.postNo,
      required this.writer,
      required this.contents,
      required this.isExpired,
      required this.isFixed,
      required this.isHidden,
      required this.isLimitedTimePost,
      required this.data,
      required this.createdAt});
  factory PostDetail.fromJson(Map<String, dynamic> json) => PostDetail(
        id: json['id'],
        boardId: json['board_id'],
        userId: json['user_id'],
        title: json['title'] ?? '',
        postNo: json['post_no'],
        writer: json['writer'] ?? '',
        contents: json['contents'] ?? '',
        isExpired: json['is_expired'],
        isFixed: json['is_fixed'],
        isHidden: json['is_hidden'],
        isLimitedTimePost: json['is_limited_time_post'],
        data: json['data'],
        createdAt: DateTime.parse(json['created_at']),
      );
}
