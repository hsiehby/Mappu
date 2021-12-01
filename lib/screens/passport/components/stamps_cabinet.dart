import 'package:flutter/material.dart';
import 'package:mappu/models/postcard.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mappu/db/database_helper.dart';

class StampsCabinet extends StatefulWidget {
  const StampsCabinet({Key? key}) : super(key: key);

  @override
  _StampsCabinetState createState() => _StampsCabinetState();
}

class _StampsCabinetState extends State<StampsCabinet> {
  List<Postcard> _postcards = [];

  Future<void> loadPostcards() async {
    final dbHelper = DatabaseHelper.instance;
    if (_postcards.isEmpty) {
      final List<Postcard> postcards = await dbHelper.getPostcards();
      setState(() {
        _postcards = postcards;
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
      child: Padding(
        // padding: const EdgeInsets.all(0.0),
        padding: const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
        child: Container(
          foregroundDecoration: _postcards[index].earned ? null
              : const BoxDecoration(
            color: Colors.grey,
            backgroundBlendMode: BlendMode.saturation,
          ),
          child: Opacity(
              opacity: _postcards[index].earned ? 1.0 : 0.30,
              child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(_postcards[index].iconPath)
              )
          ),
        ),
      ),
    );
  }

  Widget buildStampsGrid() {
    return FutureBuilder(
      future: loadPostcards(),
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
            childAspectRatio: 0.9,
            children: List.generate(_postcards.length, (index) {
              String message = _postcards[index].earned ?
              _postcards[index].description +
                  '\nEarned at: ${_postcards[index].earnedAt!.year}-'
                      '${_postcards[index].earnedAt!.month}-${_postcards[index].earnedAt!.day}'
                  : _postcards[index].description;
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
      contentPadding: const EdgeInsets.fromLTRB(5.0, 5.0, 5.0, 5.0),
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
                    foregroundDecoration: _postcards[index].earned ? null
                        : const BoxDecoration(
                      color: Colors.grey,
                      backgroundBlendMode: BlendMode.saturation,
                    ),
                    child: Image.asset(_postcards[index].iconPath, fit: BoxFit.cover)
                    // TODO: fix this
                    // child: Opacity(
                    //   opacity: _stamps[index].earned ? 1.0 : 0.30,
                    //   child: Image.asset(_stamps[index].iconPath, fit: BoxFit.cover,)
                    // ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'A postcard from ${_postcards[index].earned ? _postcards[index].name : '???'}',
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                    )
                  ),
                  const SizedBox(height: 10.0),
                  Text(_postcards[index].description),
                ]
              )
            ),
          ],
        )
      )
    );
  }
}
