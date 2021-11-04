import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _marker = {};

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
      onTap: (latlng) {
        if (_marker.length >= 1) {
          _marker.clear();
        }

        _onAddMarkerButtonPressed(latlng);
      }
    );
  }

  void _onAddMarkerButtonPressed(LatLng latlng) {
    setState(() {
      _marker.add(Marker(
        markerId: MarkerId(latlng.toString()),
        position: latlng,
        infoWindow: const InfoWindow(
          title: "A unique marker",
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      ));
    });
  }
}
