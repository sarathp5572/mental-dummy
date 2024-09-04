import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mentalhelth/widgets/functions/snack_bar.dart';
import 'package:permission_handler/permission_handler.dart';

class JournalGoogleMapWidgets extends StatefulWidget {
  const JournalGoogleMapWidgets(
      {super.key, required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  // ignore: library_private_types_in_public_api
  _JournalGoogleMapWidgetsState createState() =>
      _JournalGoogleMapWidgetsState();
}

class _JournalGoogleMapWidgetsState extends State<JournalGoogleMapWidgets> {
  PermissionStatus permissionStatus = PermissionStatus.denied;
  String currentTime = '';
  Position? _currentLocation;

  @override
  void initState() {
    super.initState();
    _checkPermissionStatus();
    _requestPermission();
    _getCurrentLocation();
  }

  Future<void> _checkPermissionStatus() async {
    final status = await Permission.locationWhenInUse.status;
    setState(() {
      permissionStatus = status;
    });
    // if (permissionStatus.is) {

    // }
  }

  Future<void> _requestPermission() async {
    final status = await Permission.locationWhenInUse.request();
    setState(() {
      permissionStatus = status;
    });
  }

  void _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      if (mounted) {
        setState(() {
          _currentLocation = position;
          _selectedLocation = LatLng(widget.latitude, widget.longitude);
        });
        _updateMarkerPosition();
        _onMapTapped(
          LatLng(
            _currentLocation!.latitude,
            _currentLocation!.longitude,
          ),
        );
      }
      // ignore: empty_catches
    } catch (e) {}
  }

  late GoogleMapController mapController;
  LatLng _selectedLocation = const LatLng(0, 0);
  String selectedAddress = '';

  void _updateMarkerPosition() {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId(
            'selected-location',
          ),
          position: _selectedLocation,
          draggable: true,
          onDragEnd: _onMarkerDragEnd,
        ),
      );
    });
  }

  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.3,
      child: Column(
        children: [
          _currentLocation == null
              ? const CircularProgressIndicator()
              : Expanded(
                  child: GoogleMap(
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                    },
                    onTap: _onMapTapped,
                    initialCameraPosition: CameraPosition(
                      target: _currentLocation == null
                          ? const LatLng(10.1632, 76.6413)
                          : LatLng(
                              _currentLocation!.latitude,
                              _currentLocation!.longitude,
                            ), // San Francisco, CA
                      zoom: 12.0,
                    ),
                    markers: _markers,
                  ),
                ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: Text(
          //     'Selected Address: $selectedAddress',
          //   ),
          // ),
        ],
      ),
    );
  }

  void _onMapTapped(LatLng location) async {
    setState(() {
      _selectedLocation = location;
    });

    // Retrieve the address using geocoding
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(location.latitude, location.longitude);
      if (placemarks != null && placemarks.isNotEmpty) {
        Placemark placemark = placemarks[0];
        setState(() {
          selectedAddress =
              '${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
        });
      }
      _updateMarkerPosition();
    } catch (e) {
      showCustomSnackBar(context: context, message: e.toString());
    }
  }

  void _onMarkerDragEnd(LatLng location) {
    _onMapTapped(location);
  }
}
