class BaseImageModel {
  final String? id;
  final String author;
  final String url;
  final String downloadUrl;

  BaseImageModel({
    required this.author,
    required this.url,
    required this.downloadUrl,
    this.id
  });

  factory BaseImageModel.fromJson(Map<String, dynamic> json) {
    return BaseImageModel(
      id: '${json['id']}',
      author: json['author'] ?? '',
      url: json['url'] ?? '',
      downloadUrl: json['download_url'] ?? '',
    );
  }

  @override
  String toString() {
    return 'BaseImageModel(author: $author, url: $url, downloadUrl: $downloadUrl)';
  }
}
