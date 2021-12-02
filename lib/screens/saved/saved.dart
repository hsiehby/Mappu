import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mappu/components/article_reader.dart';
import 'package:mappu/data/country.dart';
import 'package:mappu/db/database_helper.dart';
import 'package:mappu/models/saved_article.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../data/country.dart';

class SavedWidget extends StatelessWidget {
  const SavedWidget({Key? key}) : super(key: key);
  static const List<String> continents = [
    'Explore Page',
    'Europe',
    'Asia',
    'North America',
    'Africa',
    'Antarctica',
    'South America',
    'Oceania',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: continents.length,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
            bottom: TabBar(
              tabs: List<Widget>.generate(continents.length, (int index) {
                return Tab(text: continents[index]);
              }),
              isScrollable: true,
              indicatorColor: Colors.transparent,
              unselectedLabelColor: Colors.white,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide(color: Colors.brown, width: 2.0),
              ),
              labelColor: Colors.brown,
            ),
            title: Text(
              'Your Saved Articles',
              style: GoogleFonts.notoSans(),
            ),
            backgroundColor: Colors.orange,
            elevation: 1,
            titleTextStyle: const TextStyle(
              color: Colors.brown,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            )),
        body: TabBarView(
            children: List<Widget>.generate(continents.length, (int index) {
          return SavedList(continent: continents[index]);
        })),
      ),
    );
  }
}

class SavedList extends StatefulWidget {
  final String continent;
  final ChromeSafariBrowser browser = ArticleReader();

  SavedList({Key? key, required this.continent}) : super(key: key);

  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  final dbHelper = DatabaseHelper.instance;
  List<SavedArticle> articles = <SavedArticle>[];

  @override
  void initState() {
    super.initState();

    dbHelper.getSavedArticles().then((data) {
      setState(() {
        articles = data
            .where((i) =>
                countryDetails[i.countryId]!.continent == widget.continent)
            .toList();
      });
    });
  }

  ListTile _tile(SavedArticle article) {
    return ListTile(
      title: Text(article.title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
          )),
      subtitle: Text(timeago.format(article.pubDate),
          style: TextStyle(
            fontSize: 10.0,
            color: Colors.grey[500],
          )),
      leading: widget.continent == "Explore Page" ?
        const Icon(Icons.emoji_flags, size: 40): Card(
                child: Image.asset(
                  'assets/flags/${article.countryId.toLowerCase()}.png',
                  width: 40,
                ),
              elevation: 3.0
            ),
      onTap: () async {
        await widget.browser.open(
            url: Uri.parse(article.link),
            options: ChromeSafariBrowserClassOptions(
                android: AndroidChromeCustomTabsOptions(
                    addDefaultShareMenuItem: false),
                ios: IOSSafariOptions(barCollapsingEnabled: true)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (articles.isEmpty) {
      final String label = widget.continent;
      return Center(
          child: Text(
        'Start saving articles in $label',
        style: const TextStyle(fontSize: 18),
      ));
    }

    return ListView(
        children: List<Widget>.generate(articles.length, (int index) {
      return _tile(articles[index]);
    }));
  }
}
