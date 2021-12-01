class Postcard {
  late String postcardId;
  late String name;
  late String description;
  late bool earned;
  late DateTime? earnedAt;
  late String iconPath;

  Postcard({
    required this.postcardId,
    required this.name,
    required this.description,
    required this.earned,
    required this.earnedAt,
    required this.iconPath,
  });

  Map<String, dynamic> toMap() {
    return {
      'postcardId': postcardId,
      'name': name,
      'description': description,
      'iconPath': iconPath,
      'earned': earned ? 1 : 0,
      'earnedAt': earnedAt?.toIso8601String(),
    };
  }

  Postcard.fromJson(Map<String, dynamic> json)
    : postcardId = json['postcardId'],
      name = json['name'],
      description = json['description'],
      iconPath = json['iconPath'],
      earned = json['earned'],
      earnedAt = json['earned'] ? DateTime.parse(json['earnedAt']) : null;

  @override
  String toString() {
    return 'Postcard{postcardId: $postcardId, name: $name, description: $description, iconPath: $iconPath, earned: $earned, earnedAt: ${earnedAt?.toIso8601String()}}';
  }
}