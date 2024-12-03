import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_app/constants/constants.dart';

import 'package:location_app/resources/strings.dart';
import 'package:location_app/themes/colors.dart';
import 'package:location_app/themes/fonts.dart';
import 'package:location_app/widgets/common/form_input.dart';
import 'package:location_app/resources/icons.dart' as icons;
import 'package:location_app/widgets/common/svg_lodder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class StudentTeacherLocationWidget extends StatefulWidget {
  const StudentTeacherLocationWidget({super.key});

  @override
  State<StudentTeacherLocationWidget> createState() =>
      _StudentTeacherLocationWidgetState();
}

class _StudentTeacherLocationWidgetState
    extends State<StudentTeacherLocationWidget> {
  GoogleMapController? mapController;
  Set<Marker> markers = {};
  Set<Polyline> polylines = {};
  LatLng? currentLocation;
  LatLng? instituteLocation;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Handle permission denied
          return;
        }
      }
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        currentLocation = LatLng(position.latitude, position.longitude);
        _addMarker(currentLocation!, 'current', 'Current Location');
      });
    } catch (e) {
      print('Error getting current location: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error getting current location')),
      );
    }
  }

  void _addMarker(LatLng position, String id, String title) {
    markers.add(Marker(
      markerId: MarkerId(id),
      position: position,
      infoWindow: InfoWindow(title: title),
    ));
  }

  // Future<void> _searchInstitute(String query) async {
  //   final QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection('institutes')
  //       .where('instituteId', isEqualTo: query)
  //       .limit(1)
  //       .get();
  //   if (querySnapshot.docs.isNotEmpty) {
  //     final instituteData =
  //         querySnapshot.docs.first.data() as Map<String, dynamic>;
  //     final double latitude = instituteData['latitude'] as double;
  //     final double longitude = instituteData['longitude'] as double;

  //     setState(() {
  //       instituteLocation = LatLng(latitude, longitude);
  //       _addMarker(instituteLocation!, 'institute', 'Institute Location');
  //       _getPolyline();
  //     });
  //   }
  // }

  void _getPolyline() async {
    if (currentLocation == null || instituteLocation == null) return;

    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: constants.apiKey,
      request: PolylineRequest(
        origin:
            PointLatLng(currentLocation!.latitude, currentLocation!.longitude),
        destination: PointLatLng(
            instituteLocation!.latitude, instituteLocation!.longitude),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      polylines.clear();
      polylines.add(Polyline(
        polylineId: PolylineId('route'),
        color: Color.fromARGB(255, 40, 122, 198),
        points:
            result.points.map((e) => LatLng(e.latitude, e.longitude)).toList(),
      ));
      setState(() {});
    } else {
      print('Error: ${result.errorMessage}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${result.errorMessage}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width * 0.9,
      margin: const EdgeInsets.only(top: 5),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  Strings.searchOnGoogleMaps,
                  style: Theme.of(context).textTheme.titleSmallTitleBrown,
                ),
              ],
            ),
            const SizedBox(height: 10),
            TypeAheadField(
              loadingBuilder: (context) => const CircularProgressIndicator(),
              suggestionsCallback: (search) async {
                if (search.isEmpty) {
                  return null;
                }

                try {
                  String capitalizedSearchTerm = search[0].toUpperCase() +
                      search.substring(1).toLowerCase();
                  final QuerySnapshot querySnapshot = await FirebaseFirestore
                      .instance
                      .collection('institutes')
                      .where('instituteName',
                          isGreaterThanOrEqualTo: capitalizedSearchTerm)
                      .where('instituteName',
                          isLessThan: capitalizedSearchTerm + 'z')
                      .get();

                  return Future.value(
                      querySnapshot.docs.map((ele) => ele).toList());
                } catch (e) {
                  print('Error fetching institutes: $e');
                  return [];
                }
              },
              debounceDuration: const Duration(milliseconds: 500),
              builder: (context, controller, focusNode) {
                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  autofocus: false,
                  decoration: InputDecoration(
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide(
                        color: ThemeColors.authPrimary,
                        width: 1,
                      ),
                    ),
                    suffixIcon: const Padding(
                      padding: EdgeInsets.only(right: 8.0),
                      child: SVGLoader(
                        image: icons.Icons.search,
                      ),
                    ),
                    hintText: '   Institute Name',
                    labelStyle: Theme.of(context).textTheme.displaySmall,
                    hintStyle: Theme.of(context).textTheme.displayMedium,
                    errorStyle: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: ThemeColors.primary),
                  ),
                );
              },
              itemBuilder: (context, location) {
                return ListTile(
                  title: Text(location['instituteName'] as String),
                  subtitle: Text(
                    location['name'] as String,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                );
              },
              onSelected: (location) {
                print('location');
                setState(() {
                  instituteLocation =
                      LatLng(location['latitude'], location['longitude']);
                  _addMarker(
                      instituteLocation!, 'institute', 'Institute Location');
                  _getPolyline();

                  // Zoom and center the map to show the route
                  if (mapController != null && currentLocation != null) {
                    LatLngBounds bounds = LatLngBounds(
                      southwest: LatLng(
                        currentLocation!.latitude < instituteLocation!.latitude
                            ? currentLocation!.latitude
                            : instituteLocation!.latitude,
                        currentLocation!.longitude <
                                instituteLocation!.longitude
                            ? currentLocation!.longitude
                            : instituteLocation!.longitude,
                      ),
                      northeast: LatLng(
                        currentLocation!.latitude > instituteLocation!.latitude
                            ? currentLocation!.latitude
                            : instituteLocation!.latitude,
                        currentLocation!.longitude >
                                instituteLocation!.longitude
                            ? currentLocation!.longitude
                            : instituteLocation!.longitude,
                      ),
                    );
                    mapController!.animateCamera(
                        CameraUpdate.newLatLngBounds(bounds, 50));
                  }
                });
              },
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 300,
              child: currentLocation == null
                  ? const Center(child: CircularProgressIndicator())
                  : GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: currentLocation!,
                        zoom: 12,
                      ),
                      markers: markers,
                      polylines: polylines,
                      onMapCreated: (GoogleMapController controller) {
                        mapController = controller;
                      },
                    ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
