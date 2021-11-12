import 'package:flutter/material.dart';

class StampsCabinet extends StatefulWidget {
  const StampsCabinet({Key? key}) : super(key: key);

  @override
  _StampsCabinetState createState() => _StampsCabinetState();
}

class _StampsCabinetState extends State<StampsCabinet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Align(alignment: Alignment.center,
              child: Text("Stamps Cabinet", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),)),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GridView.count(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 3,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(100, (index) {
                  return Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Icon(Icons.menu, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: EdgeInsets.all(20),
                        primary: Colors.blue, // <-- Button color
                        onPrimary: Colors.red, // <-- Splash color
                      ),
                    )
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
