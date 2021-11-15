import 'dart:io';


class UserStats {
  late int readArticles; //number of articles the user has read
  late String name; //name of the user
  late List<dynamic> countriesVisited; //List of Countries the user has visited
  late int articlesThisWeek; //number of articles read this week
  late int countriesThisWeek; //number of countries explored this week

  UserStats({
    required this.readArticles,
    required this.name,
    required this.countriesVisited,
    required this.articlesThisWeek,
    required this.countriesThisWeek
  });

  Map<String, dynamic> toMap() {
    return {
      'readArticles': readArticles,
      'name': name,
      'countriesVisited': countriesVisited,
      'articlesThisWeek': articlesThisWeek,
      'countriesThisWeek' : countriesThisWeek

    };
  }

  UserStats.fromJson(Map<String, dynamic> json)
      : readArticles = json['readArticles'],
        name = json['name'],
        countriesVisited = json['countriesVisited'],
        articlesThisWeek = json['articlesThisWeek'],
        countriesThisWeek = json['countriesThisWeek'];

  @override
  String toString() {
    return 'UserStat{readArticles: $readArticles, name: $name, countriesVisited: $countriesVisited, articlesThisWeek: $articlesThisWeek, countriesThisWeek: $countriesThisWeek}';
  }
}