class Popup {
  dynamic id;
  String name;
  String type;
  String image;
  Popup(
      {required this.id,
      required this.name,
      required this.type,
      required this.image});
  factory Popup.fromJson(Map<String, dynamic> json) => Popup(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      image: json['data'] != null &&
              json['data']['images'] != null &&
              json['data']['images']['mobile'] != null
          ? json['data']['images']['mobile']
          : '');
}
