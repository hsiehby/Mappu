import 'package:flutter/material.dart';
import 'package:mappu/db/database_helper.dart';
import 'package:mappu/models/stats.dart';

class StatsView extends StatefulWidget {
  const StatsView({Key? key}) : super(key: key);

  @override
  _StatsViewState createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  Future<Stats>? _stats;

  Future<Stats> fetchStats() async {
    final dbHelper = DatabaseHelper.instance;
    int numArticlesRead = await dbHelper.getReadArticlesCount();
    int numCountriesExplored = await dbHelper.getExploredCountriesCount();
    return Stats(numArticlesRead: numArticlesRead, numCountriesExplored: numCountriesExplored);
  }

  @override
  void initState() {
    _stats = fetchStats();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _stats,
      builder: (context, snapshot) {
        String numArticlesReadMsg = '';
        String numCountriesExploredMsg = '';

        if (snapshot.hasData) {
          Stats stats = snapshot.data as Stats;
          numArticlesReadMsg = stats.numArticlesRead.toString() + ' articles';
          numCountriesExploredMsg = stats.numCountriesExplored.toString() + ' countries';
        } else {
          numArticlesReadMsg = snapshot.error.toString();
          numCountriesExploredMsg = snapshot.error.toString();
        }

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
                          numArticlesReadMsg,
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
                          numCountriesExploredMsg,
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
    );
  }
}
