import 'package:flutter/material.dart';
import 'package:mappu/models/saved_article.dart';
import '../../db/database_helper.dart';

 class SavedWidget extends StatefulWidget {
  const SavedWidget({Key? key}) : super(key: key);

  @override
  State<SavedWidget> createState() => _SavedWidgetState();
}

class _SavedWidgetState extends State<SavedWidget> {
  late List<SavedArticle> savedArticles;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
    );
  }

  Future refreshSavedArticles() async {
    SavedArticle savedArticle = SavedArticle(articleId: "hello",
      title: 'article title',
      link: 'article link',
      pubDate: DateTime.now(),
      source: 'bbc',
      sourceURL: 'bbc.com',
      countryId: 'JP',
      savedAt: DateTime.now(),
    );
    await DatabaseHelper.instance.insertSavedArticle(savedArticle);

    savedArticles = await DatabaseHelper.instance.getSavedArticles();
    print(savedArticles);
  }

  @override
  void initState() {
    super.initState();

    refreshSavedArticles();
  }
}