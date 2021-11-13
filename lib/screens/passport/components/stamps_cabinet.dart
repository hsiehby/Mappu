import 'package:flutter/material.dart';
import 'package:mappu/models/stamp.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class StampsCabinet extends StatefulWidget {
  const StampsCabinet({Key? key}) : super(key: key);

  @override
  _StampsCabinetState createState() => _StampsCabinetState();
}

class _StampsCabinetState extends State<StampsCabinet> {
  Future<void> loadStamps() async {
    // await Future.delayed(Duration(seconds: 1));
    if (_stamps.isEmpty) {
      final String response = await rootBundle.loadString('assets/stamps/stamps.json');
      final data = await jsonDecode(response);
      final List<Stamp> stamps = data.map<Stamp>((item) => (Stamp.fromJson(item))).toList();
      setState(() {
        _stamps = stamps;
      });
    }
  }

  List<Stamp> _stamps = [];

  // final List<Stamp> _stamps = [
  //   Stamp(stampId: 'test1',
  //       name: 'Traveler',
  //       description: 'Earn this stamp by exploring at least 3 countries',
  //       earned: true,
  //       earnedAt: DateTime.utc(2021, 9, 25),
  //       iconPath: 'assets/stamps/mountain.png'),
  //   Stamp(stampId: 'test2',
  //       name: 'Sailor',
  //       description: 'Earn this stamp by exploring at least 10 countries',
  //       earned: true,
  //       earnedAt: DateTime.utc(2021, 10, 19),
  //       iconPath: 'assets/stamps/natural.png'),
  //   Stamp(stampId: 'test3',
  //       name: 'Adventurer',
  //       description: 'Earn this stamp by exploring at least 30 countries',
  //       earned: false,
  //       earnedAt: null,
  //       iconPath: 'assets/stamps/forest.jpeg'),
  //   Stamp(stampId: 'test3',
  //       name: 'Expeditioner',
  //       description: 'Earn this stamp by exploring at least 100 countries',
  //       earned: false,
  //       earnedAt: null,
  //       iconPath: 'assets/stamps/city.png'),
  // ];
  
  Widget buildStamp(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            foregroundDecoration: _stamps[index].earned ? null
                : const BoxDecoration(
              color: Colors.grey,
              backgroundBlendMode: BlendMode.saturation,
            ),
            child: Opacity(
                opacity: _stamps[index].earned ? 1.0 : 0.25,
                child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage(_stamps[index].iconPath)
                )
            ),
          ),
        ),
        Text(_stamps[index].name,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600
          ),
        ),
      ],
    );
  }

  Widget buildStampsGrid() {
    return FutureBuilder(
      future: loadStamps(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SpinKitWanderingCubes(
            color: Colors.blueGrey,
            size: 50.0,
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return GridView.count(
            crossAxisCount: 3,
            childAspectRatio: 0.85,
            children: List.generate(_stamps.length, (index) {
              String message = _stamps[index].earned ?
              _stamps[index].description +
                  '\nEarned at: ${_stamps[index].earnedAt!.year}-'
                      '${_stamps[index].earnedAt!.month}-${_stamps[index].earnedAt!.day}'
                  : _stamps[index].description;
              return Tooltip(
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.9),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                ),
                message: message,
                child: buildStamp(index),
              );
            }),
          );
        }
      }
    );
  }

  // List<Widget> buildStampsList() {
  //   return List.generate(_stamps.length, (index) {
  //     String message = _stamps[index].earned ?
  //       _stamps[index].description +
  //           '\nEarned at: ${_stamps[index].earnedAt!.year}-'
  //               '${_stamps[index].earnedAt!.month}-${_stamps[index].earnedAt!.day}'
  //       : _stamps[index].description;
  //     return Tooltip(
  //       decoration: BoxDecoration(
  //         color: Colors.green.withOpacity(0.9),
  //         borderRadius: const BorderRadius.all(Radius.circular(4)),
  //       ),
  //       message: message,
  //       child: buildStamp(index),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: Align(alignment: Alignment.center,
                child: Text("Stamps Cabinet", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),)),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: buildStampsGrid(),
            ),
          ),
        ],
      ),
    );
  }
}
