import 'package:http/http.dart';
import 'package:xml/xml.dart';
import 'package:mappu/models/news_article.dart';
import 'dart:io';

class NewsAPI {
  late String location;

  NewsAPI({required this.location});

  Future<List<NewsArticle>> getData() async {
    List<NewsArticle> articles = <NewsArticle>[];
    try {

      Response response = await get(Uri.parse('https://news.google.com/rss/headlines/section/geo/$location'));
      final document = XmlDocument.parse(response.body);
      // print(document);
      final items = document.findAllElements('item');
      for (var node in items) {
        String trimmedTitle = node.getElement('title')!.text;
        trimmedTitle = trimmedTitle.substring(0, trimmedTitle.lastIndexOf('-'));
        DateTime pubDate = HttpDate.parse(node.getElement('pubDate')!.text);

        articles.add(
            NewsArticle(
              title: trimmedTitle,
              link: node.getElement('link')!.text,
              pubDate: pubDate,
              source: node.getElement('source')!.text,
              sourceURL: node.getElement('source')!.getAttribute('url')!,
              guid: node.getElement('guid')!.text,
            )
        );

        print(node.getElement('guid')!.text);
      }


      return articles;

    } catch (e) {
      print("Caught error: $e");
      return articles;
    }
  }
}