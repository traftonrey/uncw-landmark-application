// ignore_for_file: unused_import, avoid_print

import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String? error;
  List<Position> positions = [];
  bool isProcessing = false;
  // ignore: unused_field
  GoogleMapController? _controller;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  static const CameraPosition _uncwBellTower = CameraPosition(
    target: LatLng(34.2271592, -77.8729786),
    zoom: 15,
  );

  @override
  void initState() {
    super.initState();

    // Create some markers.
    // Markers in Google Maps must have unique identifiers.
    MarkerId congdonMarkerId = const MarkerId("Congdon Hall");
    final Marker congdonHallMarker = Marker(
      markerId: congdonMarkerId,
      infoWindow: InfoWindow(
        title: congdonMarkerId.value,
        onTap: () => print("You pressed on ${congdonMarkerId.value}!"),
      ),
      position: const LatLng(34.2261004, -77.873966),
    );
    markers[congdonMarkerId] = congdonHallMarker;

    MarkerId randallMarkerId = const MarkerId("Randall Library");
    final Marker randallMarker = Marker(
      markerId: randallMarkerId,
      infoWindow: InfoWindow(
        title: randallMarkerId.value,
        snippet: "Study here!",
        onTap: () => print("You pressed on ${randallMarkerId.value}!"),
      ),
      position: const LatLng(34.227766, -77.876411),
    );
    markers[randallMarkerId] = randallMarker;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Map Screen")),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _uncwBellTower,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
    );
  }

  _getLocation() async {
    error = null;

    // Test if location services are enabled.
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      error = 'Location services are disabled.';
    }

    // Has the user already granted permission?
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again.
        //
        // Your App should show an explanatory UI now.
        error = 'Location permissions are denied';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      error =
          'Location permissions are permanently denied, we cannot request permissions.';
    }

    // Check that everything okay, then access the position of the device.
    if (error == null) {
      // Trigger a rebuild to indicate the location is processing.
      setState(() {
        isProcessing = true;
      });
      // This await blocks execution.
      Position pos = await Geolocator.getCurrentPosition();
      positions.add(pos);
      isProcessing = false; // Processing is finished.
    }

    // Trigger the rebuild.
    setState(() {});
  }
}
