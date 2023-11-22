class Popup {
  dynamic id;
  String name;
  String type;
  String image;
  String place;
  Popup(
      {required this.id,
      required this.name,
      required this.type,
      required this.image,
      required this.place});
  factory Popup.fromJson(Map<String, dynamic> json) => Popup(
      id: json['id'],
      name: json['name'],
      type: json['type'],
      image: json['data'] != null &&
              json['data']['images'] != null &&
              json['data']['images']['mobile'] != null
          ? json['data']['images']['mobile']
          : '',
      place: json['data'] != null ? json['data']['place'] : 'M');
}
