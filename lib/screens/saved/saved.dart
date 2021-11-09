import 'package:flutter/material.dart';
import 'package:mappu/db/database_helper.dart';
import 'package:mappu/models/saved_article.dart';
import 'package:timeago/timeago.dart' as timeago;

class SavedWidget extends StatelessWidget {
  const SavedWidget({Key? key}) : super(key: key);
  static const List<String> continents = ['AF','AN','AS','EU','NA','OC','SA'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: continents.length,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
              tabs: List<Widget>.generate(continents.length, (int index) {
                return Tab(text: continents[index]);
              })
          ),
          title: const Text('Your Saved Articles'),
        ),
        body: TabBarView(
          children: List<Widget>.generate(continents.length, (int index) {
            return SavedList(continent: continents[index]);
          })
        ),
      ),
    );
  }
}

class SavedList extends StatefulWidget {
  final String continent;
  const SavedList({Key? key, required this.continent}) : super(key: key);

  @override
  _SavedListState createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  final dbHelper = DatabaseHelper.instance;
  List<SavedArticle> articles = <SavedArticle>[];

  @override
  void initState() {
    super.initState();

    dbHelper.insertSavedArticle(
        SavedArticle(articleId: 'CAIiEFMihBT82FS05z6fggz80FoqFwgEKg4IACoGCAowl6p7MN-zCTDZ4PsF',
            title: 'Death row inmates sue over Japan\'s brief notice of execution',
            link: 'https://news.google.com/__i/rss/rd/articles/CBMieGh0dHBzOi8vd3d3LnRoZWd1YXJkaWFuLmNvbS93b3JsZC8yMDIxL25vdi8wNS9qYXBhbi1kZWF0aC1yb3ctaW5tYXRlcy1zdWUtb3Zlci1zYW1lLWRheS1ub3RpZmljYXRpb24tb2YtZXhlY3V0aW9uLXJlcG9ydNIBeGh0dHBzOi8vYW1wLnRoZWd1YXJkaWFuLmNvbS93b3JsZC8yMDIxL25vdi8wNS9qYXBhbi1kZWF0aC1yb3ctaW5tYXRlcy1zdWUtb3Zlci1zYW1lLWRheS1ub3RpZmljYXRpb24tb2YtZXhlY3V0aW9uLXJlcG9ydA?oc=5',
            pubDate: DateTime(2021,11,05),
            source: 'The Guardian',
            sourceURL: 'https://www.theguardian.com',
            countryId: 'JP',
            savedAt: DateTime(2021,11,08)));

    dbHelper.getSavedArticles()
        .then((data) {
          setState(() {
            articles = data;
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
        leading: Icon(Icons.emoji_flags)
    );
  }

  @override
  Widget build(BuildContext context) {

    return ListView(
      children: List<Widget>.generate(articles.length, (int index) {
        return _tile(articles[index]);
      })
    );
  }

}