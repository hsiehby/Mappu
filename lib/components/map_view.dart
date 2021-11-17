import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mappu/screens/explore/explore.dart';

const DEFAULT_LAT_LNG = LatLng(46.2276, 2.2137);

class MapView extends StatefulWidget {
  final Function updateCountry, showToast;
  final String location;
  final LatLng latLng;

  const MapView({Key? key, required this.updateCountry, required this.showToast,
    required this.location, required this.latLng}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _marker = {};

  String currCountry = "";

  @override
  Widget build(BuildContext context) {

    final targetLatLng = widget.latLng == NO_LAT_LNG ? DEFAULT_LAT_LNG : widget.latLng;

    _controller.future.then((value) async {
      value.animateCamera(
          CameraUpdate.newLatLng(targetLatLng)
      );
    });

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
            if (newPlace[0].country == null || newPlace[0].country!.isEmpty) {
              throw Exception();
            }

            currCountry = newPlace[0].country ?? "Unknown Country";

            if (_marker.isNotEmpty) {
              _marker.clear();
            }

            _onAddMarkerButtonPressed(latlng);
          } catch (err) {
            widget.showToast(Colors.redAccent, Icons.block, "Invalid Location");
          }
        }
    );
  }

  void _onAddMarkerButtonPressed(LatLng latlng) async {

    _marker.add(Marker(
      markerId: MarkerId("1"),
      position: latlng,
      infoWindow: InfoWindow(
        title: currCountry,
        snippet: "(Tap again to remove marker)"
      ),
      draggable: false,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      onTap: () {
          _marker.clear();
          currCountry = "Unknown Country";
          widget.updateCountry(currCountry, latlng);
      }
    ));

    widget.updateCountry(currCountry, latlng);
  }
}
