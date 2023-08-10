class Language {
  String ko;
  String? en;
  Language({required this.ko, this.en});

  factory Language.fromJson(Map<String, dynamic> json) =>
      Language(ko: json['ko'] ?? (json['en'] ?? ''), en: json['en']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> body = Map<String, dynamic>();
    body['ko'] = ko;
    return body;
  }
}

class BasicResponse {
  String message;
  bool status;
  BasicResponse({required this.message, required this.status});

  factory BasicResponse.fromJson(Map<String, dynamic> json) => BasicResponse(
      message: json['message'] != null ? json['message'].toString() : '',
      status: json['status']);
}
