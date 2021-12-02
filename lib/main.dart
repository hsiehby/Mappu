import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'screens/explore/explore.dart';
import 'screens/saved/saved.dart';
import 'screens/passport/passport.dart';
import 'package:flutter_config/flutter_config.dart';

GlobalKey globalKey = GlobalKey();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables(); // Load .env which includes API keys

  runApp(const MaterialApp(
      home: Home()
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List _children = [
    const ExploreWidget(),
    const SavedWidget(),
    const PassportWidget(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: ShowCaseWidget(
          builder: Builder(builder: (context) => _children[_currentIndex],)
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0 ? const Icon(Icons.location_pin) : const Icon(Icons.location_on_outlined),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1 ? const Icon(Icons.bookmark) : const Icon(Icons.bookmark_border),
            label: "Saved",
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 2 ? const Icon(Icons.star) : const Icon(Icons.star_border),
            label: "Passport",
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}

