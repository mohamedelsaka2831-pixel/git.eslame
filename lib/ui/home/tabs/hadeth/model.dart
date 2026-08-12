class HadethModel {
  final int id;
  final String title;
  final String text;
  final String source;

  HadethModel({
    required this.id,
    required this.title,
    required this.text,
    required this.source,
  });

  factory HadethModel.fromJson(Map<String, dynamic> json) {
    return HadethModel(
      id: json['id'] as int,
      title: json['title'] as String,
      text: json['text'] as String,
      source: json['source'] as String,
    );
  }
}