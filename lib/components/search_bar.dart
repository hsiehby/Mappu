import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mappu/data/country_to_latlng.dart';
import 'package:mappu/screens/explore/explore.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import '../data/country_to_continent.dart' as c_to_c;

class SearchBar extends StatefulWidget {
  final void Function(String, LatLng) setValue;
  final void Function(Color, IconData, String) showToast;
  final FloatingSearchBarController controller;
  const SearchBar({Key? key, required this.setValue, required this.controller,
    required this.showToast }) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  var countrySuggestions = [];

  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      clearQueryOnClose: false,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      borderRadius: BorderRadius.circular(24.0),
      debounceDelay: const Duration(milliseconds: 100),
      controller: widget.controller,
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
        setState(() {
          if (query.trim() != '') {
            countrySuggestions = countryList.where((country) =>
                country.toLowerCase().startsWith(query.trim().toLowerCase())).toList();
          } else {
            countrySuggestions = countryList;
          }
        });
      },
      onSubmitted: (String value) {
        final int numValues = countryList.where((country) =>
            country == value).length;
        if (numValues == 1) {
          widget.setValue(value, testMap[value] ?? NO_LAT_LNG);
        } else {
          widget.showToast(Colors.deepOrange, Icons.block, "Invalid Location");
        }
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      leadingActions: [
        const FloatingSearchBarAction(
          showIfOpened: false,
          child: Icon(Icons.search),
        ),
        FloatingSearchBarAction.back(
          showIfClosed: false,
        ),
      ],
      actions: [
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SingleChildScrollView(
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: countrySuggestions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(countrySuggestions[index]),
                    onTap: () {
                      widget.setValue(countrySuggestions[index], testMap[countrySuggestions[index]] ?? NO_LAT_LNG);
                    },
                  );
                },
              ),
            ),
          )
        );
      },
    );
  }
}
