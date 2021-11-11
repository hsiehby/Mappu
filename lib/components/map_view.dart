import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mappu/main.dart';

class MapView extends StatefulWidget {
  final Function updateCountry;

  const MapView({Key? key, required this.updateCountry}) : super(key: key);

  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Completer<GoogleMapController> _controller = Completer();
  final Set<Marker> _marker = {};

  late FToast fToast;
  String currCountry = "";

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(46.2276, 2.2137),
    zoom: 4,
  );

  @override
  void initState() {
    fToast = FToast();
    fToast.init(globalKey.currentState!.context);
  }

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
            _showToast();
          }
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
            currCountry = "Unknown Country";
            widget.updateCountry(currCountry);
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

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.block, color: Colors.white,),
          SizedBox(
            width: 12.0,
          ),
          Text("Invalid Country",
            style: TextStyle(
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
}
