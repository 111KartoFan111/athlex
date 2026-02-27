class ChallengeModel {
  final int id;
  final String title;
  final String? description;
  final int durationDays;
  final String targetMetric;

  const ChallengeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.durationDays,
    required this.targetMetric,
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> json) {
    return ChallengeModel(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String?,
      durationDays: (json['durationDays'] as num).toInt(),
      targetMetric: json['targetMetric'] as String,
    );
  }
}
