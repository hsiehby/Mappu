import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  final Function updateCountry;

  const MapView({Key? key, required this.updateCountry}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _marker = {};

  String currCountry = "";

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(46.2276, 2.2137),
    zoom: 4,
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _initialPosition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: _marker,
      onTap: (latlng) async {
        List<Placemark> newPlace = await placemarkFromCoordinates(latlng.latitude, latlng.longitude);
        currCountry = newPlace[0].country ?? "Unknown Country";

        if (_marker.isNotEmpty) {
          _marker.clear();
        }
        
        _onAddMarkerButtonPressed(latlng);
      }
    );
  }

  void _onAddMarkerButtonPressed(LatLng latlng) async {

    setState(() {
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
          setState(() {
            _marker.clear();
            currCountry = "";
          });
        }
      ));
    });

    _controller.future.then((value) async {
      value.animateCamera(
          CameraUpdate.newLatLng(latlng)
      );
      await Future.delayed(Duration(seconds: 1));
      value.showMarkerInfoWindow(MarkerId("1"));
    });

    widget.updateCountry(currCountry);
  }
}
