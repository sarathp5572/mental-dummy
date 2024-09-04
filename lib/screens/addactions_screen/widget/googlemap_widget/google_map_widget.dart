import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mentalhelth/screens/addactions_screen/provider/add_actions_provider.dart';
import 'package:mentalhelth/utils/core/image_constant.dart';
import 'package:mentalhelth/widgets/custom_image_view.dart';
import 'package:mentalhelth/widgets/functions/snack_bar.dart';
import 'package:provider/provider.dart';

class AddActionGoogleMap extends StatefulWidget {
  const AddActionGoogleMap({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddActionGoogleMapState createState() => _AddActionGoogleMapState();
}

class _AddActionGoogleMapState extends State<AddActionGoogleMap> {
  late GoogleMapController mapController;
  LatLng _selectedLocation = const LatLng(0, 0);
  String _selectedAddress = '';

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
          Expanded(
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              onTap: _onMapTapped,
              initialCameraPosition: const CameraPosition(
                target: LatLng(10.1632, 76.6413), // San Francisco, CA
                zoom: 12.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId(
                    'selected-location',
                  ),
                  position: _selectedLocation,
                  draggable: true,
                  onDragEnd: _onMarkerDragEnd,
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
            location: location,
          );
          // addActionsProvider.selectedLocationName =
          //     placemark.locality.toString();
          // addActionsProvider.selectedLocationAddress =
          //     _selectedAddress.toString();
          // addActionsProvider.selectedLatitude = location.latitude.toString();
          // addActionsProvider.locationLongitude = location.longitude.toString();
        });
      }
    } catch (e) {
      showCustomSnackBar(
        context: context,
        message: e.toString(),
      );
    }
  }

  void _onMarkerDragEnd(LatLng location) {
    _onMapTapped(location);
  }
}
