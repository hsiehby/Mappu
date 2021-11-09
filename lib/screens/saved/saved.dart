import 'package:flutter/material.dart';
import 'package:mappu/models/news_article.dart';
import 'package:timeago/timeago.dart' as timeago;

class SavedWidget extends StatelessWidget {
  const SavedWidget({Key? key}) : super(key: key);
  static const List<Tab> tabs = <Tab>[
    Tab(text: 'AF'),
    Tab(text: 'AN'),
    Tab(text: 'AS'),
    Tab(text: 'EU'),
    Tab(text: 'NA'),
    Tab(text: 'OC'),
    Tab(text: 'SA'),
  ];

  Widget _buildList() {
    return ListView(
      children: [
        _tile(NewsArticle(title: "Safety meeting ends in accident",
            link: "http://google.com/",
            pubDate: DateTime(2021,11,03),
            source: "The Cat",
            sourceURL: "google.com")),
        _tile(NewsArticle(title: "World Bank says poor need more money",
            link: "http://google.com/",
            pubDate: DateTime(2021,10,21),
            source: "The Cat",
            sourceURL: "google.com")),
        _tile(NewsArticle(title: "Murderer says detective ruined his reputation",
            link: "http://google.com/",
            pubDate: DateTime(2021,10,15),
            source: "The Cat",
            sourceURL: "google.com")),
        _tile(NewsArticle(title: "Man gets 30 years then slaps attorney",
            link: "http://google.com/",
            pubDate: DateTime(2021,10,1),
            source: "The Cat",
            sourceURL: "google.com")),
      ],
    );
  }

  ListTile _tile(NewsArticle article) {
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
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: tabs
            ),
            title: const Text('Your Saved Articles'),
          ),
          body: TabBarView(
            children: [
              _buildList(),
              _buildList(),
              _buildList(),
              _buildList(),
              _buildList(),
              _buildList(),
              _buildList(),
            ],
          ),
        ),
      );
  }
}
