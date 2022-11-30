// ignore_for_file: unused_import

import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goWander,
        label: const Text('Wander!'),
        icon: const Icon(Icons.hiking),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _goWander() {
    Random random = Random();
    double randomLatitude = random.nextDouble() * 180 - 90;
    double randomLongitude = random.nextDouble() * 360 - 180;
    print("Going to $randomLongitude, $randomLongitude");

    CameraPosition destination = CameraPosition(
        bearing: random.nextDouble() * 360,
        target: LatLng(randomLatitude, randomLongitude),
        tilt: 79.5,
        zoom: 5);

    _controller?.animateCamera(CameraUpdate.newCameraPosition(destination));
  }
}
