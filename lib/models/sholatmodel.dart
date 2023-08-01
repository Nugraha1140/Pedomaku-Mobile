class ModelSholat {
  final String name;
  final String arabic;
  final String latin;
  final String terjemahan;

  ModelSholat({
    required this.name,
    required this.arabic,
    required this.latin,
    required this.terjemahan,
  });

  factory ModelSholat.fromJson(Map<String, dynamic> json) {
    return ModelSholat(
      name: json['name'],
      arabic: json['arabic'],
      latin: json['latin'],
      terjemahan: json['terjemahan'],
    );
  }
}
