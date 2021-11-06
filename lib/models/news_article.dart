class NewsArticle {
  late String title;
  late String link;
  late DateTime pubDate;
  late String source;
  late String sourceURL;
  late String guid;

  NewsArticle({
    required this.title,
    required this.link,
    required this.pubDate,
    required this.source,
    required this.sourceURL,
    required this.guid,
  });
}