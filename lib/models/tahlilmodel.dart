class ModelTahlil {
  final String title;
  final String arabic;
  final String translation;

  ModelTahlil({
    required this.title,
    required this.arabic,
    required this.translation,
  });

  factory ModelTahlil.fromJson(Map<String, dynamic> json) {
    return ModelTahlil(
      title: json['title'],
      arabic: json['arabic'],
      translation: json['translation'],
    );
  }
}
