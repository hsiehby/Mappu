import 'package:flutter/material.dart';
import 'package:mappu/services/news_api.dart';
import 'package:mappu/models/news_article.dart';
import 'package:mappu/components/article_reader.dart';
import 'package:mappu/components/search_bar.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:mappu/services/string_casing_extension.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:mappu/components/map_view.dart';

class ExploreWidget extends StatefulWidget {
  const ExploreWidget({Key? key}) : super(key: key);

  @override
  State<ExploreWidget> createState() => _ExploreWidgetState();
}

class _ExploreWidgetState extends State<ExploreWidget> {
  final ChromeSafariBrowser browser = ArticleReader();
  final FloatingSearchBarController searchBarController = FloatingSearchBarController();

  List<NewsArticle> articles = <NewsArticle>[];
  String location = "Japan";

  Widget articleItemBuilder(context, index) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 4.0, 4.0, 4.0),
      child: InkWell(
        onTap: () async {
          await browser.open(
              url: Uri.parse(articles[index].link),
              options: ChromeSafariBrowserClassOptions(
                  android: AndroidChromeCustomTabsOptions(
                      addDefaultShareMenuItem: false),
                  ios: IOSSafariOptions(barCollapsingEnabled: true)));
        },
        child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
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
            )
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    // Fetch articles for initial location
    NewsAPI(location: location)
        .getData()
        .then((data) {
      setState(() {
        articles = data;
      });
    });
  }

  Widget buildBottomSheet() {
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
                      Text(
                          "Trending in ${location.toTitleCase()}",
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 20,
                          )
                      )
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Expanded(
                    flex: 1,
                    child: ListView.separated(
                        itemCount: articles.length,
                        controller: scrollController,
                        itemBuilder: articleItemBuilder,
                        separatorBuilder: (BuildContext context, int index) => const Divider(height: 8.0)
                    ),
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const MapView(),
        SafeArea(
            child: buildBottomSheet()
        ),
        SearchBar(
          controller: searchBarController,
          setValue: (String s) {
            // Update location and fetch articles
            setState(() {
              location = s.toLowerCase();
            });

            NewsAPI(location: location)
                .getData()
                .then((data) {
              setState(() {
                articles = data;
              });
            });

            // Close search bar on submit
            if (searchBarController.isOpen) {
              searchBarController.close();
            }
          },
        ),
      ],
    );
  }
}
