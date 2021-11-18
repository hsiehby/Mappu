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
    return InkWell(
      onTap: () {
          showDialog(context: context, builder: (context) {
            return buildPostcardDetailsView(context, index);
          });
      },
      child: Column(
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
                  opacity: _stamps[index].earned ? 1.0 : 0.30,
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
      ),
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

  Widget buildPostcardDetailsView(BuildContext context, int index) {
    return AlertDialog(
      contentPadding: EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      content: SizedBox(
        width: 400.0,
        height: 380.0,
        child: Column(
          children: [
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  iconSize: 48.0,
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200.0,
                    foregroundDecoration: _stamps[index].earned ? null
                        : const BoxDecoration(
                      color: Colors.grey,
                      backgroundBlendMode: BlendMode.saturation,
                    ),
                    child: Image.asset(_stamps[index].iconPath, fit: BoxFit.cover)
                    // TODO: fix this
                    // child: Opacity(
                    //   opacity: _stamps[index].earned ? 1.0 : 0.30,
                    //   child: Image.asset(_stamps[index].iconPath, fit: BoxFit.cover,)
                    // ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'A postcard from ${_stamps[index].earned ? _stamps[index].name : '???'}',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    )
                  ),
                  const SizedBox(height: 10.0),
                  Text(_stamps[index].description),
                ]
              )
            ),
          ],
        )
      )
    );
  }
}
