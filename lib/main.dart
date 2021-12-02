import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/explore/explore.dart';
import 'screens/saved/saved.dart';
import 'screens/passport/passport.dart';
import 'package:flutter_config/flutter_config.dart';

GlobalKey globalKey = GlobalKey();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required by FlutterConfig
  await FlutterConfig.loadEnvVariables(); // Load .env which includes API keys

  runApp(MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.notoSansTextTheme()
      ),
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
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: _currentIndex == 0 ?
              const Icon(IconData(0xe4c9, fontFamily: 'MaterialIcons')) :
              const Icon(IconData(0xf2ac, fontFamily: 'MaterialIcons')),
            label: "Explore",
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 1 ?
              const Icon(IconData(0xe0f1, fontFamily: 'MaterialIcons')) :
              const Icon(IconData(0xeee2, fontFamily: 'MaterialIcons')),
            label: "Saved",
          ),
          BottomNavigationBarItem(
            icon: _currentIndex == 2 ?
            const Icon(IconData(0xe06d, fontFamily: 'MaterialIcons')) :
            const Icon(IconData(0xee5e, fontFamily: 'MaterialIcons')),
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

