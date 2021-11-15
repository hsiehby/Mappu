import 'package:flutter/material.dart';
import 'package:mappu/screens/passport/components/level_bar.dart';
import 'package:mappu/screens/passport/components/user_statistics.dart';
import 'components/stamps_cabinet.dart';

class PassportWidget extends StatelessWidget {
  const PassportWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Scaffold(
              appBar: AppBar(title: const Text("Your Passport"), backgroundColor: const Color.fromARGB(255,255,143,81),)
          ),
          StampsCabinet(),
          LevelBar(),
          UserStatistics()
        ],
      )
    );
  }
}
