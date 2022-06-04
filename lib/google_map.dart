import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:page_transition/page_transition.dart';
import 'package:rimo_tech/my_order.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Location location = new Location();

  late double _latitude;
  late double _longitude;

  Position? _currentPosition;

  bool _isOnline = false;

  late bool _serviceEnabled;
  late PermissionStatus _permissionGranted;
  late LocationData _locationData;

  Future<Position> _getPosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.deniedForever) {
        return Future.error('Location not avilable');
      }
    } else {
      print('Location not available');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future _getCurrentLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();

    _latitude = _locationData.latitude!;
    _longitude = _locationData.longitude!;

    location.onLocationChanged.listen((LocationData currentLocation) {
      // Use current location
      if (kDebugMode) print(_locationData);
    });
  }

  final Completer<GoogleMapController> _controller = Completer();

  // ignore: prefer_final_fields
  // static CameraPosition _kGooglePlex = CameraPosition(
  //   // target: LatLng(37.42796133580664, -122.085749655962),
  //   target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
  //   zoom: 14.4746,
  // );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.42796133580664, -122.085749655962),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  @override
  void initState() {
    super.initState();

    // _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Stack(
          children: [
            GoogleMap(
              myLocationEnabled: true,
              mapType: MapType.normal,
              initialCameraPosition: const CameraPosition(
                target: LatLng(37.42796133580664, -122.085749655962),
                // target: LatLng(6.596282, 3.355294),
                zoom: 14.4746,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                setState(() async {
                  _currentPosition = await _getPosition();
                });
              },
            ),
            Positioned(
                bottom: 250,
                left: 40,
                child: IconButton(
                  icon: Image.asset('assets/map_gift.png'),
                  onPressed: () {},
                )),
            Positioned(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                child: IconButton(
                  icon: Image.asset('assets/balance_bg.png'),
                  onPressed: () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: const MyOrder(),
                        type: PageTransitionType.fade,
                      ),
                    );
                  },
                )),
            Positioned(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.2,
                child: IconButton(
                  icon: Image.asset('assets/balance_text.png'),
                  onPressed: () {
                    Navigator.of(context).push(
                      PageTransition(
                        child: const MyOrder(),
                        type: PageTransitionType.fade,
                      ),
                    );
                  },
                )),
            // child: const  Text('NGN 2800', style: TextStyle(color: Colors.white),)),
          ],
        ),
      ),
      floatingActionButton: _floatingWidgets(),
    );
  }

  Widget _floatingWidgets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 40, bottom: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text('Hi, Richard,', style: TextStyle(fontSize: 20)),
              Text(_isOnline ? 'You are offline' : 'You are online'),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                _isOnline = !_isOnline;
              });
            },
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.blue.shade300,
              shadowColor: Colors.white,
              elevation: 3,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: BorderSide(color: Colors.green.shade50)),
            ),
            child: Ink(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: _isOnline
                      ? [Colors.green.shade50, Colors.green.shade50]
                      : [Colors.red.shade50, Colors.red.shade50],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: 50,
                alignment: Alignment.center,
                child: Text(
                  _isOnline ? 'Go Online' : 'Go offLine',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color:
                        _isOnline ? Colors.green.shade200 : Colors.red.shade200,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
