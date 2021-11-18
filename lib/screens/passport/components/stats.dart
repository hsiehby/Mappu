import 'package:flutter/material.dart';

class Stats extends StatefulWidget {
  const Stats({Key? key}) : super(key: key);

  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  int _num_articles_read = 25;
  int _num_countries_explored = 11;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300, width: 1.5),
            borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Padding(
              //   padding: EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 20.0),
              //   //Changed the top side padding to orient on passport page for now
              //   //Need to change literal ints to variables based on size of device if we care about it looking good on any phone
              //   child: Align(alignment: Alignment.centerLeft,
              //       child: Text("Statistics", style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.normal),)),
              // ),
              // Badge icons
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'This past week, you have read',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        color: Colors.grey.shade600
                      ),
                    ),
                    Text(
                      '$_num_articles_read articles',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 32.0,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 28.0),
                    Text(
                      'This past week, you have explored',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 14.0,
                          color: Colors.grey.shade600
                      ),
                    ),
                    Text(
                      '$_num_countries_explored countries',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 32.0,
                        height: 1.4,
                      ),
                    ),
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
