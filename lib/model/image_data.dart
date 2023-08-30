class ImageData {
  String thumbnail;
  Map<String, dynamic>? images;
  ImageData({required this.thumbnail, this.images});
  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
      thumbnail:
          json['thumbnail'] != null ? json['thumbnail'].values.toList()[0] : '',
      images: json['images']);
}
