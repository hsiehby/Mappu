class Stamp {
  late String stampId;
  late String name;
  late String description;
  late bool earned;
  late DateTime? earnedAt;
  late String iconPath;

  Stamp({
    required this.stampId,
    required this.name,
    required this.description,
    required this.earned,
    required this.earnedAt,
    required this.iconPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'stampId': stampId,
      'name': name,
      'description': description,
      'iconPath': iconPath,
      'earned': earned,
      'earnedAt': earnedAt?.toIso8601String(),
    };
  }

  Stamp.fromJson(Map<String, dynamic> json)
    : stampId = json['stampId'],
      name = json['name'],
      description = json['description'],
      iconPath = json['iconPath'],
      earned = json['earned'],
      earnedAt = json['earned'] ? DateTime.parse(json['earnedAt']) : null;

  @override
  String toString() {
    return 'Stamp{stampId: $stampId, name: $name, description: $description, iconPath: $iconPath, earned: $earned, earnedAt: ${earnedAt?.toIso8601String()}}';
  }
}