class Level {
  late int number;
  late String name;
  late double progress;

  Level({
    required this.number,
    required this.name,
    required this.progress
  });

  Map<String, dynamic> toMap() {
    return {
      'number': number,
      'name': name,
      'progress': progress
    };
  }

  Level.fromJson(Map<String, dynamic> json)
      : number = json['number'],
        name = json['name'],
        progress = json['progress'];

  @override
  String toString() {
    return 'Level{Number: $number, name: $name, progress: $progress}';
  }
}