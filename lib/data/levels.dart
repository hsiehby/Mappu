final levels = [
  Level(title: 'Curious Kitten', max: 200),
  Level(title: 'Catographer', max: 500),
  Level(title: 'Pawsome Explorer', max: 1000),
  Level(title: 'Meowco Polo', max: 5000),
];

class Level {
  late String title;
  late int max;

  Level({
    required this.title,
    required this.max,
  });
}
