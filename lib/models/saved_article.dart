class SavedArticle {
  late String title;
  late String link;
  late DateTime pubDate;
  late String source;
  late String sourceURL;
  late String articleId;
  late String countryId;
  late DateTime savedAt;

  SavedArticle({
    required this.title,
    required this.link,
    required this.pubDate,
    required this.source,
    required this.sourceURL,
    required this.articleId,
    required this.countryId,
    required this.savedAt,
  });
}