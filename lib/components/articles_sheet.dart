import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mappu/data/country.dart';
import 'package:mappu/db/database_helper.dart';
import 'package:mappu/models/explored_country.dart';
import 'package:mappu/models/read_article.dart';
import 'package:mappu/models/saved_article.dart';
import 'package:mappu/models/news_article.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:timeago/timeago.dart' as timeago;

class ArticlesSheet extends StatelessWidget {
  ArticlesSheet({Key? key,
    required this.browser,
    required this.articles,
    required this.location,
    required this.showToast,
    required this.articleKey,}) : super(key: key);

  final ChromeSafariBrowser browser;
  final List<NewsArticle> articles;
  final String location;
  final Function showToast;
  final GlobalKey articleKey;
  final dbHelper = DatabaseHelper.instance;

  _saveArticle(NewsArticle article, String location) {
    final dbHelper = DatabaseHelper.instance;
    dbHelper.insertSavedArticle(
      SavedArticle.withNewsArticle(article, location)
    );
    showToast(Colors.grey, Icons.bookmark_border, "Saved");
  }

  Widget buildItem(index) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(0, 4.0, 4.0, 4.0),
        child: Slidable(
          actionPane: const SlidableDrawerActionPane(),
          // slide from left
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Save',
              icon: Icons.bookmark_border,
              onTap: () => _saveArticle(articles[index], location),
            )
          ],
          actionExtentRatio: 0.25,
          child: InkWell(
            onTap: () async {
              await browser.open(
                  url: Uri.parse(articles[index].link),
                  options: ChromeSafariBrowserClassOptions(
                      android: AndroidChromeCustomTabsOptions(
                          addDefaultShareMenuItem: false),
                      ios: IOSSafariOptions(barCollapsingEnabled: true)));
              await dbHelper.insertReadArticle(ReadArticle(
                  articleId: articles[index].articleId,
                  readAt: DateTime.now()));
              await dbHelper.insertExploredCountry(ExploredCountry(
                  countryId: location,
                  exploredAt: DateTime.now()));
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      articles[index].source,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      )
                  ),
                  const SizedBox(height: 3.0),
                  Text(
                      articles[index].title,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: -0.5,
                      )
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          timeago.format(articles[index].pubDate),
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey[500],
                          )
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        )
    );
  }

  Widget articleItemBuilder(context, index) {
    return index == 0 ? Showcase(
        key: articleKey,
        child: buildItem(index),
        description: 'Save article by sliding left and tapping on save icon') :
      buildItem(index);
  }

  Widget buildHeaderForList() {
    return IgnorePointer(
      child: Column(
        children: [
          Container(
              width: 32.0,
              height: 5.0,
              margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5.0),
              )
          ),
          Row(
            children: [
              location == "Unknown Country" ? const Text(
                  "Explore Recommendations",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  )
              )
                  : Flexible(
                  child: Text(
                    "Trending in ${countryDetails[location]!.name}",
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                    overflow: TextOverflow.ellipsis,
                  )
              )
            ],
          ),
          const SizedBox(height: 16.0,),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.3,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    blurRadius: 5.0,
                    color: Colors.grey.shade500,
                  )
                ]
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
              child: Stack(
                children: [
                  ListView.separated(
                      itemCount: articles.length,
                      controller: scrollController,
                      itemBuilder: (BuildContext context, int index) {
                        return index == 0 ? buildHeaderForList()
                            : articleItemBuilder(context, index - 1);
                      },
                      separatorBuilder: (BuildContext context, int index) => const Divider(height: 8.0)
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

}