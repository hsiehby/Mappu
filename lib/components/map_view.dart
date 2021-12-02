import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mappu/data/country.dart';
import 'package:mappu/db/database_helper.dart';
import 'package:mappu/models/explored_country.dart';
import 'package:mappu/screens/explore/explore.dart';

const DEFAULT_LAT_LNG = LatLng(46.2276, 2.2137);

class MapView extends StatefulWidget {
  final Function updateCountry, showToast, setFromSearchFalse;
  final String location;
  final LatLng latLng;
  bool fromSearch;

  MapView({Key? key,
    required this.updateCountry,
    required this.showToast,
    required this.location,
    required this.latLng,
    required this.fromSearch,
    required this.setFromSearchFalse})
      : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _marker = {};
  final dbHelper = DatabaseHelper.instance;

  String currCountry = "";

  @override
  Widget build(BuildContext context) {
    if (widget.fromSearch) {
      searchBarAddMarker(widget.location, widget.latLng);
      widget.fromSearch = false;
    }

    final targetLatLng =
    widget.latLng == NO_LAT_LNG ? DEFAULT_LAT_LNG : widget.latLng;

    CameraPosition _initialPosition = CameraPosition(
      target: targetLatLng,
      zoom: 4,
    );

    print(widget.latLng);

    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _initialPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _marker,
        onTap: (latlng) async {
          try {
            List<Placemark> newPlace = await placemarkFromCoordinates(
                latlng.latitude, latlng.longitude);
            if (newPlace[0].isoCountryCode == null || newPlace[0].isoCountryCode!.isEmpty) {
              throw Exception();
            }

            currCountry = newPlace[0].isoCountryCode ?? "Unknown Country";

            if (_marker.isNotEmpty) {
              _marker.clear();
            }

            onTapAddMarker(latlng);
            dbHelper.insertExploredCountry(ExploredCountry(
                countryId: currCountry, exploredAt: DateTime.now()));
            } catch (err)
            {
              widget.showToast(
                  Colors.deepOrange, Icons.block, "Invalid Location");
            }
          });
  }

  void onTapAddMarker(LatLng latlng) async {
    setState(() {
      _marker.add(Marker(
          markerId: MarkerId("1"),
          position: latlng,
          infoWindow: InfoWindow(
              title: countryDetails[currCountry]!.name,
              snippet: "(Tap again to remove marker)"
          ),
          draggable: false,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          onTap: () {
            _marker.clear();
            currCountry = "Unknown Country";
            widget.updateCountry(currCountry, latlng);
          }));
    });

    _controller.future.then((value) async {
      value.animateCamera(CameraUpdate.newLatLng(latlng));
      await Future.delayed(Duration(seconds: 1));
      value.showMarkerInfoWindow(MarkerId("1"));
    });

    widget.updateCountry(currCountry, latlng);
  }

  void searchBarAddMarker(String location, LatLng latLng) {
    _marker.clear();
    if (location.length != 2) {
      location = countryToCode[location]!;
    }
    currCountry = location;
    setState(() {
      _marker.add(Marker(
          markerId: MarkerId("1"),
          position: latLng,
          infoWindow: InfoWindow(
              title: location.length == 2 ? countryDetails[location]!.name : location, snippet: "(Tap again to remove marker)"),
          draggable: false,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          onTap: () {
            _marker.clear();
            currCountry = "Unknown Country";
            widget.updateCountry(currCountry, latLng);
          }));
    });
    dbHelper.insertExploredCountry(ExploredCountry(
        countryId: currCountry, exploredAt: DateTime.now()));

    _controller.future.then((value) async {
      value.hideMarkerInfoWindow(MarkerId("1"));
      value.animateCamera(CameraUpdate.newLatLng(latLng));
      await Future.delayed(Duration(seconds: 1));
      value.showMarkerInfoWindow(MarkerId("1"));
    });

    widget.setFromSearchFalse();
  }
}
