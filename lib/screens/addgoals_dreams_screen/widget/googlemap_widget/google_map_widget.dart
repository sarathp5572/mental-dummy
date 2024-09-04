import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mentalhelth/screens/addgoals_dreams_screen/provider/ad_goals_dreams_provider.dart';
import 'package:mentalhelth/utils/core/image_constant.dart';
import 'package:mentalhelth/widgets/custom_image_view.dart';
import 'package:mentalhelth/widgets/functions/snack_bar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AddGoalsGoogleMap extends StatefulWidget {
  const AddGoalsGoogleMap({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddGoalsGoogleMapState createState() => _AddGoalsGoogleMapState();
}

class _AddGoalsGoogleMapState extends State<AddGoalsGoogleMap> {
  PermissionStatus permissionStatus = PermissionStatus.denied;
  String currentTime = '';
  Position? _currentLocation;

  @override
  void initState() {
    super.initState();
    _checkPermissionStatus();
    _requestPermission();
    _getCurrentLocation();
    // if (permissionStatus.isGranted) {
    // _getCurrentLocation();
    // }
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
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentLocation = position;
      _selectedLocation = LatLng(position.latitude, position.longitude);

      _updateMarkerPosition();
      _onMapTapped(
        LatLng(
          _currentLocation!.latitude,
          _currentLocation!.longitude,
        ),
      );
      // 'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
    });
  }

  late GoogleMapController mapController;
  LatLng _selectedLocation = const LatLng(0, 0);
  String _selectedAddress = '';

  void _updateMarkerPosition() {
    setState(() {
      markers.clear();
      markers.add(
        Marker(
          markerId: const MarkerId('selected-location'),
          position: _selectedLocation,
          draggable: true,
          onDragEnd: _onMarkerDragEnd,
        ),
      );
    });
  }

  Set<Marker> markers = {};

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.4,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop(); // Close the bottom sheet
                },
                child: CustomImageView(
                  imagePath: ImageConstant.imgClosePrimary,
                  height: 30,
                  width: 30,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
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
                    markers: markers,
                  ),
                ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Selected Address: $_selectedAddress',
            ),
          ),
        ],
      ),
    );
  }

  void _onMapTapped(LatLng location) async {
    AdDreamsGoalsProvider adDreamsGoalsProvider =
        Provider.of<AdDreamsGoalsProvider>(context, listen: false);
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
          _selectedAddress =
              '${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
          adDreamsGoalsProvider.addLocationSection(
              selectedAddress: _selectedAddress,
              placemark: placemark,
              location: location);
          // adDreamsGoalsProvider.selectedLocationName =
          //     placemark.locality.toString();
          // adDreamsGoalsProvider.selectedLocationAddress =
          //     _selectedAddress.toString();
          // adDreamsGoalsProvider.selectedLatitude = location.latitude.toString();
          // adDreamsGoalsProvider.locationLongitude =
          //     location.longitude.toString();
          // log(adDreamsGoalsProvider.selectedLocationName.toString(),
          //     name: "selected 1");
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
