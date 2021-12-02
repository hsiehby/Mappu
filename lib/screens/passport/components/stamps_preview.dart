import 'package:flutter/material.dart';
import 'package:mappu/models/postcard.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mappu/screens/passport/components/stamps_cabinet.dart';
import 'package:mappu/db/database_helper.dart';

class PostcardsPreview extends StatefulWidget {
  const PostcardsPreview({Key? key}) : super(key: key);

  @override
  _PostcardsPreviewState createState() => _PostcardsPreviewState();
}

class _PostcardsPreviewState extends State<PostcardsPreview> {
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 0.0, 0, 10.0),
      child: Container(
        foregroundDecoration: _postcards[index].earned ? null
            : const BoxDecoration(
          color: Colors.grey,
          backgroundBlendMode: BlendMode.saturation,
        ),
        child: Opacity(
            opacity: _postcards[index].earned ? 1.0 : 0.25,
            child: CircleAvatar(
                radius: 40.0,
                backgroundImage: AssetImage(_postcards[index].iconPath)
            )
        ),
      ),
    );
  }

  Widget buildStampsList() {
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
            return ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(_postcards.length, (index) {
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StampsCabinet()),
                    );
                  },
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
