class AppModel {
  final String id;
  final String name;
  final String description;
  final String iconUrl;
  final int humanTrustScore;
  final String source; // Official Store, External APK
  final bool isApk;
  final String downloadUrl;
  final String securityReputation; // Safe, Risk

  AppModel({
    required this.id,
    required this.name,
    required this.description,
    required this.iconUrl,
    required this.humanTrustScore,
    required this.source,
    required this.isApk,
    required this.downloadUrl,
    required this.securityReputation,
  });

  factory AppModel.fromJson(Map<String, dynamic> json) {
    return AppModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      iconUrl: json['icon'] ?? '',
      humanTrustScore: json['human_trust_score'] ?? 0,
      source: json['source'] ?? 'Unknown',
      isApk: json['is_apk'] ?? false,
      downloadUrl: json['download_url'] ?? '',
      securityReputation: json['security_reputation'] ?? 'Unknown',
    );
  }
}
