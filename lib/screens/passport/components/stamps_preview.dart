import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mappu/models/stamp.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_spinkit/flutter_spinkit.dart';

class StampsPreview extends StatefulWidget {
  const StampsPreview({Key? key}) : super(key: key);

  @override
  _StampsPreviewState createState() => _StampsPreviewState();
}

class _StampsPreviewState extends State<StampsPreview> {
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0, 10.0),
      child: Container(
        foregroundDecoration: _stamps[index].earned ? null
            : const BoxDecoration(
          color: Colors.grey,
          backgroundBlendMode: BlendMode.saturation,
        ),
        child: Opacity(
            opacity: _stamps[index].earned ? 1.0 : 0.25,
            child: CircleAvatar(
                radius: 40.0,
                backgroundImage: AssetImage(_stamps[index].iconPath)
            )
        ),
      ),
    );
  }

  Widget buildStampsList() {
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
            return ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(_stamps.length, (index) {
                return buildStamp(index);
              })
            );
          }
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300, width: 1.5),
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 20.0),
              //Changed the top side padding to orient on passport page for now
              //Need to change literal ints to variables based on size of device if we care about it looking good on any phone
              child: Align(alignment: Alignment.centerLeft,
                  child: Text("Postcards collected", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal),)),
            ),
            // Badge icons
            SizedBox(
              height: 80.0,
              child: buildStampsList(),
            ),
            // View all button
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 0.0, 8.0, 4.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 18.0),
                  ),
                  onPressed: () {},
                  child: const Text('View All'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
