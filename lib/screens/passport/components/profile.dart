import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String name = "Elon Musk";
  final int level = 3;
  final String levelTitle = "Travel Enthusiast";
  final int points = 2350;
  final int currentLevelLower = 2000;
  final int currentLevelUpper = 3000;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(28.0, 0.0, 28.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500)),
            Text(
              "Level $level $levelTitle",
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w300,
                height: 2.0,
              )),
            Text(
              "$points points • ${currentLevelUpper - points} points until next level",
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
                color: Colors.grey.shade600,
                height: 1.2,
              )
            )
          ]
        ),
      )
    );
  }
}
