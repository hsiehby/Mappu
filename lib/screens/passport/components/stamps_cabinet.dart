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
  List<Stamp> _stamps = [];

  Future<void> loadStamps() async {
    if (_stamps.isEmpty) {
      final String response = await rootBundle.loadString('assets/stamps/stamps.json');
      final data = await jsonDecode(response);
      final List<Stamp> stamps = data.map<Stamp>((item) => (Stamp.fromJson(item))).toList();
      setState(() {
        _stamps = stamps;
      });
    }
  }
  
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Postcards"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Column(
        children: [
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
