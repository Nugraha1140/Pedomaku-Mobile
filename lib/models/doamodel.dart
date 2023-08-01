class ModelDoa {
  final String title;
  final String arabic;
  final String latin;
  final String translation;

  ModelDoa({
    required this.title,
    required this.arabic,
    required this.latin,
    required this.translation,
  });

  factory ModelDoa.fromJson(Map<String, dynamic> json) {
    return ModelDoa(
      title: json['title'],
      arabic: json['arabic'],
      latin: json['latin'],
      translation: json['translation'],
    );
  }
}
