import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mappu/data/levels.dart';
import 'package:mappu/db/database_helper.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String name = "Elon Musk";
  final int currentLevelLower = 2000;
  final dbHelper = DatabaseHelper.instance;

  Future<Progress> getLevel() async {
    Progress p = Progress(points: 0, level: 0, levelMax: 0, title: '');
    p.points = (await dbHelper.getReadArticlesCount())*50;
    p.points += (await dbHelper.getExploredCountriesCount())*150;

    for (var i=0; i<levels.length; i++) {
      if (levels[i].max > p.points) {
        p.level = i+1;
        p.title = levels[i].title;
        p.levelMax = levels[i].max;
        break;
      }
    }
    return p;
  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      future: getLevel(),
      builder: (context, AsyncSnapshot<Progress> snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(28.0, 0.0, 28.0, 0.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Text(name, style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500)),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                            "${snapshot.data!.title}",
                            style: GoogleFonts.montserrat(
                              fontSize: 38.0,
                              fontWeight: FontWeight.bold,
                              // height: 2.0,
                            )),
                      ),
                      Text(
                          "Level ${snapshot.data!.level} • ${snapshot.data!.points} points",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.orange,
                          )),
                      Text(
                          "${snapshot.data!.levelMax - snapshot.data!.points} points until next level",
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey.shade600,
                            // height: 1.2,
                          )
                      )
                    ]
                ),
              )
          );
        } else {
          return const Text("Loading Profile...");
        }
      }
    );
  }
}

class Progress {
  late int points;
  late int level;
  late int levelMax;
  late String title;

  Progress({
    required this.points,
    required this.level,
    required this.levelMax,
    required this.title,
  });
}