import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mappu/components/articles_sheet.dart';
import 'package:mappu/services/news_api.dart';
import 'package:mappu/models/news_article.dart';
import 'package:mappu/components/article_reader.dart';
import 'package:mappu/components/search_bar.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:mappu/components/map_view.dart';
import 'package:mappu/main.dart';
import 'package:showcaseview/showcaseview.dart';

const NO_LAT_LNG = LatLng(90, 91);

class ExploreWidget extends StatefulWidget {
  const ExploreWidget({Key? key}) : super(key: key);

  @override
  State<ExploreWidget> createState() => _ExploreWidgetState();
}

class _ExploreWidgetState extends State<ExploreWidget> {
  GlobalKey _one = GlobalKey();

  final ChromeSafariBrowser browser = ArticleReader();
  final FloatingSearchBarController searchBarController = FloatingSearchBarController();

  List<NewsArticle> articles = <NewsArticle>[];
  String location = "Unknown Country";
  LatLng latLng = NO_LAT_LNG;
  bool fromSearch = false;
  late FToast fToast;

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

    fToast = FToast();
    fToast.init(globalKey.currentState!.context);

    WidgetsBinding.instance!.addPostFrameCallback((_) =>
        ShowCaseWidget.of(context)!.startShowCase([_one])
    );
  }

  updateLocation(String country, LatLng newLatLng) {
    // Skip if country already loaded
    if (location == country) { return; }

    location = country;
    latLng = newLatLng;

    NewsAPI(location: location)
        .getData()
        .then((data) {
      setState(() {
        articles = data;
      });
    });
  }

  setFromSearchFalse() {
    fromSearch = false;
  }

  showToast(Color color, IconData icon, String text) {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: color,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white,),
          const SizedBox(
            width: 12.0,
          ),
          Text(text,
            style: const TextStyle(
              color: Colors.white,
            ),),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MapView(updateCountry: updateLocation, showToast: showToast,
            location: location, latLng: latLng, fromSearch: fromSearch,
            setFromSearchFalse: setFromSearchFalse,),
        SafeArea(
            child: ArticlesSheet(browser: browser,
              articles: articles,
              location: location,
              showToast: showToast,
              articleKey: _one,
            )
        ),
        SearchBar(
          controller: searchBarController,
          showToast: showToast,
          setValue: (String s, LatLng latlng) {
            // Update location and fetch articles
            location = s;
            latLng = latlng;
            fromSearch = true;

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
