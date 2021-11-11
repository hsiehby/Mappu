import 'package:mappu/models/news_article.dart';

class SavedArticle {
  late String articleId;
  late String title;
  late String link;
  late DateTime pubDate;
  late String source;
  late String sourceURL;
  late String countryId;
  late DateTime savedAt;

  SavedArticle({
    required this.articleId,
    required this.title,
    required this.link,
    required this.pubDate,
    required this.source,
    required this.sourceURL,
    required this.countryId,
    required this.savedAt,
  });

  SavedArticle.withNewsArticle(NewsArticle article, String location) {
    articleId = article.articleId;
    title = article.title;
    link = article.link;
    pubDate = article.pubDate;
    source = article.source;
    sourceURL = article.sourceURL;
    countryId = location;
    savedAt = DateTime.now();
  }

  Map<String, dynamic> toMap() {
    return {
      'articleId': articleId,
      'title': title,
      'link': link,
      'pubDate': pubDate.toIso8601String(),
      'source': source,
      'sourceURL': sourceURL,
      'countryId': countryId,
      'savedAt': savedAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'SavedArticle{articleId: $articleId, title: $title, link: $link, '
        'pubDate: $pubDate, source: $source, sourceURL: $sourceURL, '
        'countryId: $countryId, savedAt: $savedAt}';
  }
}

