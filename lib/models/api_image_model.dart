import 'package:authorised_image_picker/models/base_image_model.dart';

class ApiImageModel extends BaseImageModel {
  final int width;
  final int height;

  ApiImageModel({
    required super.author,
    required super.downloadUrl,
    required super.url,
    required super.id,
    required this.width,
    required this.height,
  });

  factory ApiImageModel.fromJson(Map<String, dynamic> json) {
    return ApiImageModel(
      id: '${json['id']}',
      author: json['author'] ?? '',
      width: json['width'] ?? 0,
      height: json['height'] ?? 0,
      url: json['url'] ?? '',
      downloadUrl: json['download_url'] ?? '',
    );
  }

  @override
  String toString() {
    return 'ApiImageModel(id: $id, author: $author, width: $width, height: $height, url: $url, downloadUrl: $downloadUrl)';
  }
}
