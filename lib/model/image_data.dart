class ImageData {
  String thumbnail;
  Map<dynamic, dynamic>? images;
  ImageData({required this.thumbnail, this.images});
  factory ImageData.fromJson(Map<dynamic, dynamic> json) => ImageData(
      thumbnail:
          json['thumbnail'] != null ? json['thumbnail'].values.toList()[0] : '',
      images: json['images']);
}
