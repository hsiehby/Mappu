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

