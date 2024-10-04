class DataModel {
  final int id;
  final String title;
  final String url;

  DataModel({
    required this.id,
    required this.title,
    required this.url}

      );

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      title: json['title'],
      url: json['url'],
    );
  }
}