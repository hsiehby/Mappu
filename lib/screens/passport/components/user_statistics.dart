import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mappu/models/user_stats.dart';

class UserStatistics extends StatefulWidget {
  const UserStatistics({Key? key}) : super(key: key);

  @override
  _UserStatisticsState createState() => _UserStatisticsState();
}

class _UserStatisticsState extends State<UserStatistics> {
  List<UserStats> _userStats = [];
  String countriesVisited = "";
  int readArticles = 0;

  Future<void> loadUserStats() async {
    if (_userStats.isEmpty) {
      final String response = await rootBundle.loadString(
          'assets/userStats.json');
      final data = await jsonDecode(response);
      final List<UserStats> userStats = data.map<UserStats>((item) =>
      (UserStats.fromJson(item))).toList();
      setState(() {
        _userStats = userStats;
        countriesVisited = _userStats[0].countriesVisited.toString();
        readArticles = _userStats[0].readArticles.toInt();

      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadUserStats(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitWanderingCubes(
              color: Colors.blueGrey,
              size: 50.0,
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child:Text("You have read $readArticles articles"),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                    child: Text("You have visited the following Countries: $countriesVisited"),

                ),
                Container(
                    padding: EdgeInsets.all(10),
                    child: ElevatedButton(
                          onPressed:(){},
                          style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255,255,143,81)),
                          child: Text("View More Statistics")
                    )
                )
              ]
            );
          }
        }
    );
  }
}