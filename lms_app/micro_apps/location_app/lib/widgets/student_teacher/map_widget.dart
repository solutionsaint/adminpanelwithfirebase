import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location_app/models/location_model.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location_app/constants/constants.dart';

class RouteMapWidget extends StatefulWidget {
  final LocationModel source;
  final LocationModel destination;

  const RouteMapWidget({
    Key? key,
    required this.source,
    required this.destination,
  }) : super(key: key);

  @override
  _RouteMapWidgetState createState() => _RouteMapWidgetState();
}

class _RouteMapWidgetState extends State<RouteMapWidget> {
  GoogleMapController? _mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _setMarkers();
    _getPolyline();
  }

  void _setMarkers() {
    _markers.add(Marker(
      markerId: MarkerId('source'),
      position: LatLng(widget.source.latitude, widget.source.longitude),
      infoWindow: InfoWindow(title: 'Source'),
    ));
    _markers.add(Marker(
      markerId: MarkerId('destination'),
      position:
          LatLng(widget.destination.latitude, widget.destination.longitude),
      infoWindow: InfoWindow(title: 'Destination'),
    ));
  }

  void _getPolyline() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey: constants.apiKey,
      request: PolylineRequest(
        origin: PointLatLng(widget.source.latitude, widget.source.longitude),
        destination: PointLatLng(
            widget.destination.latitude, widget.destination.longitude),
        mode: TravelMode.driving,
      ),
    );

    if (result.points.isNotEmpty) {
      List<LatLng> polylineCoordinates = result.points
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();

      setState(() {
        _polylines.add(Polyline(
          polylineId: PolylineId('route'),
          color: Colors.blue,
          points: polylineCoordinates,
          width: 5,
        ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(widget.source.latitude, widget.source.longitude),
              zoom: 12,
            ),
            markers: _markers,
            polylines: _polylines,
            onMapCreated: (controller) {
              _mapController = controller;
            },
          ),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
