import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mentalhelth/screens/addactions_screen/provider/add_actions_provider.dart';
import 'package:mentalhelth/utils/core/image_constant.dart';
import 'package:mentalhelth/widgets/custom_image_view.dart';
import 'package:mentalhelth/widgets/functions/snack_bar.dart';
import 'package:provider/provider.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';
import 'package:mentalhelth/utils/core/image_constant.dart';
import 'package:mentalhelth/widgets/custom_image_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../../home_screen/provider/home_provider.dart';
import '../../../mental_strength_add_edit_screen/provider/mental_strenght_edit_provider.dart';


class AddActionGoogleMap extends StatefulWidget {
  const AddActionGoogleMap({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddActionGoogleMapState createState() => _AddActionGoogleMapState();
}

class _AddActionGoogleMapState extends State<AddActionGoogleMap> {
  PermissionStatus permissionStatus = PermissionStatus.denied;
  String currentTime = '';
  Position? _currentLocation;
  late MentalStrengthEditProvider mentalStrengthEditProvider;
  late  double? savedLatitude = 0.0;
  late  double? savedLongitude = 0.0;
  var logger = Logger();

  @override
  void initState() {
    super.initState();
    mentalStrengthEditProvider = Provider.of<MentalStrengthEditProvider>(context, listen: false);
    savedLatitude = double.parse(mentalStrengthEditProvider.actionsDetailsModel?.actions?.location?.locationLatitude ?? "0.0");
    savedLongitude = double.parse(mentalStrengthEditProvider.actionsDetailsModel?.actions?.location?.locationLongitude ?? "0.0");
    logger.w("savedLatitude ${savedLatitude}");
    logger.w("savedLatitude ${savedLongitude}");
    if (savedLatitude != null && savedLongitude != null) {
      // If saved location exists, set the selected location and update the map
      _selectedLocation = LatLng(savedLatitude ?? 0.0, savedLongitude ?? 0.0);
      _updateMarkerPosition();
    } else {
      // Request location permission and get the current location
      _checkPermissionStatus();
      _requestPermission();
      _getCurrentLocation();
    }
    // if (permissionStatus.isGranted) {
    // _getCurrentLocation();
    // }
  }

  double parseDouble(String? value) {
    if (value == null || value.isEmpty) {
      return 0.0; // Default value if null or empty
    }
    try {
      return double.parse(value);
    } catch (e) {
      return 0.0; // Default value if parsing fails
    }
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

  // void _getCurrentTime() {
  //   setState(() {
  //     currentTime = DateTime.now().toString();
  //   });
  // }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    if (mounted) {
      setState(() {
        _currentLocation = position;
        _selectedLocation = LatLng(position.latitude, position.longitude);
      });
      _updateMarkerPosition();
      _onMapTapped(
        LatLng(
          _currentLocation!.latitude,
          _currentLocation!.longitude,
        ),
      );
    }

    // setState(() {
    //
    // });
  }

  late GoogleMapController mapController;
  LatLng _selectedLocation = const LatLng(0, 0);
  String _selectedAddress = '';

  void _updateMarkerPosition() {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('selected-location'),
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
                  imagePath: ImageConstant.imgClosePrimaryNew,
                  height: 40,
                  width: 40,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // _currentLocation == null ||
          // _selectedLocation == null
          //     ? const CircularProgressIndicator()
          //     :
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              onTap: _onMapTapped,
              initialCameraPosition: CameraPosition(
                target: _selectedLocation.latitude != 0 && _selectedLocation.longitude != 0
                    ? _selectedLocation
                    : const LatLng(10.1632, 76.6413),
                zoom: 10.0,  // Adjust zoom for faster pan perception
              ),
              markers: _markers,
              scrollGesturesEnabled: true,
              zoomGesturesEnabled: true,
              tiltGesturesEnabled: true,
              rotateGesturesEnabled: true,
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer(),
                ),
              },
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
    AddActionsProvider addActionsProvider =
    Provider.of<AddActionsProvider>(context, listen: false);
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
          addActionsProvider.addLocationSection(
              selectedAddress: _selectedAddress,
              placemark: placemark,
              location: location);
        });
      }
      _updateMarkerPosition();
      // ignore: empty_catches
    } catch (e) {}
  }

  void _onMarkerDragEnd(LatLng location) {
    _onMapTapped(location);
  }
}

// class AddActionGoogleMap extends StatefulWidget {
//   const AddActionGoogleMap({super.key});
//
//   @override
//   // ignore: library_private_types_in_public_api
//   _AddActionGoogleMapState createState() => _AddActionGoogleMapState();
// }
//
// class _AddActionGoogleMapState extends State<AddActionGoogleMap> {
//   late GoogleMapController mapController;
//   LatLng _selectedLocation = const LatLng(0, 0);
//   String _selectedAddress = '';
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SizedBox(
//       height: size.height * 0.4,
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               const SizedBox(),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).pop(); // Close the bottom sheet
//                 },
//                 child: CustomImageView(
//                   imagePath: ImageConstant.imgClosePrimary,
//                   height: 30,
//                   width: 30,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 10),
//           Expanded(
//             child: GoogleMap(
//               onMapCreated: (GoogleMapController controller) {
//                 mapController = controller;
//               },
//               onTap: _onMapTapped,
//               initialCameraPosition: const CameraPosition(
//                 target: LatLng(10.1632, 76.6413), // San Francisco, CA
//                 zoom: 12.0,
//               ),
//               markers: {
//                 Marker(
//                   markerId: const MarkerId(
//                     'selected-location',
//                   ),
//                   position: _selectedLocation,
//                   draggable: true,
//                   onDragEnd: _onMarkerDragEnd,
//                 ),
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Selected Address: $_selectedAddress',
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void _onMapTapped(LatLng location) async {
//     AddActionsProvider addActionsProvider =
//         Provider.of<AddActionsProvider>(context, listen: false);
//     setState(() {
//       _selectedLocation = location;
//     });
//
//     // Retrieve the address using geocoding
//     try {
//       List<Placemark> placemarks =
//           await placemarkFromCoordinates(location.latitude, location.longitude);
//       if (placemarks != null && placemarks.isNotEmpty) {
//         Placemark placemark = placemarks[0];
//         setState(() {
//           _selectedAddress =
//               '${placemark.name}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
//           addActionsProvider.addLocationSection(
//             selectedAddress: _selectedAddress,
//             placemark: placemark,
//             location: location,
//           );
//           // addActionsProvider.selectedLocationName =
//           //     placemark.locality.toString();
//           // addActionsProvider.selectedLocationAddress =
//           //     _selectedAddress.toString();
//           // addActionsProvider.selectedLatitude = location.latitude.toString();
//           // addActionsProvider.locationLongitude = location.longitude.toString();
//         });
//       }
//     } catch (e) {
//       showCustomSnackBar(
//         context: context,
//         message: e.toString(),
//       );
//     }
//   }
//
//   void _onMarkerDragEnd(LatLng location) {
//     _onMapTapped(location);
//   }
// }
