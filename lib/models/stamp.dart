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

  @override
  String toString() {
    return 'Stamp{stampId: $stampId, name: $name, description: $description, iconPath: $iconPath, earned: $earned, earnedAt: ${earnedAt?.toIso8601String()}}';
  }
}