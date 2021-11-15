import 'package:flutter/material.dart';
import 'package:mappu/models/level.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LevelBar extends StatefulWidget {
  const LevelBar({Key? key}) : super(key: key);

  @override
  _LevelBarState createState() => _LevelBarState();
}

class _LevelBarState extends State<LevelBar> {
  List<Level> _levels = [];

  Future<void> loadLevels() async {
    if (_levels.isEmpty) {
      final String response = await rootBundle.loadString(
          'assets/levels.json');
      final data = await jsonDecode(response);
      final List<Level> levels = data.map<Level>((item) =>
      (Level.fromJson(item))).toList();
      setState(() {
        _levels = levels;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadLevels(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SpinKitWanderingCubes(
              color: Colors.blueGrey,
              size: 50.0,
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 150),
              child: Column(
                children: <Widget>[
                  Text(
                    _levels[0].name,
                    style: const TextStyle(fontSize: 15),
                  ),
                  LinearProgressIndicator(
                    value: _levels[0].progress,
                    semanticsLabel: 'Level progress indicator',
                    minHeight: 10,
                    color: const Color.fromARGB(255,255,143,81),
                    backgroundColor: const Color.fromARGB(255,87,85,90),
                  ),
                ],
              ),
            );
          }
        }
    );
  }
}
