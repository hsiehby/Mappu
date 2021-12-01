import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ArticleReader extends ChromeSafariBrowser {
  final DateTime openedAt = DateTime.now();

  @override
  void onOpened() {
    // print("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad() {
    // print("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    // print("ChromeSafari browser closed");
  }
}