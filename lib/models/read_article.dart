class ReadArticle {
  late String articleId;
  late DateTime readAt;

  ReadArticle({
    required this.articleId,
    required this.readAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'articleId': articleId,
      'readAt': readAt.toIso8601String(),
    };
  }

  @override
  String toString() {
    return 'SavedArticle{articleId: $articleId, readAt: $readAt}';
  }
}