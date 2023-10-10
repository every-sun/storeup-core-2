import 'dart:convert';

List<CustomerNotification> notificationFromJson(String str) =>
    List<CustomerNotification>.from(
        json.decode(str).map((x) => CustomerNotification.fromJson(x)));

class CustomerNotification {
  String id;
  DateTime date;
  String type;
  String content;
  bool isRead;

  CustomerNotification(
      {required this.id,
      required this.date,
      required this.type,
      required this.content,
      required this.isRead});

  factory CustomerNotification.fromJson(Map<String, dynamic> json) =>
      CustomerNotification(
          id: json['id'],
          date: DateTime.parse(json['date']),
          type: json['type'],
          content: json['content'],
          isRead: json['is_read']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['date'] = date.toString();
    data['type'] = type;
    data['content'] = content;
    data['is_read'] = isRead;
    return data;
  }
}
