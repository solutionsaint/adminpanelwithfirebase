import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:location_app/models/location_model.dart';
import 'package:location_app/utils/logger/logger.dart';

class LocationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final log = CustomLogger.getLogger('LocationService');

  Future<String?> addLocation(
      LocationModel location, String instituteId) async {
    try {
      // QuerySnapshot querySnapshot =
      //     await _firestore.collection('institutes').limit(1).get();
      // String instituteId = querySnapshot.docs.first.id;
      await _firestore.collection('institutes').doc(instituteId).set(
        {
          'name': location.name,
          'placeId': location.placeId,
          'latitude': location.latitude,
          'longitude': location.longitude,
        },
        SetOptions(merge: true),
      );

      return location.placeId;
    } catch (e) {
      log.e('Error adding location: $e');
      return null;
    }
  }

  Future<LocationModel?> getInstituteLocation(String instituteId) async {
    try {
      DocumentSnapshot querySnapshot =
          await _firestore.collection('institutes').doc(instituteId).get();
      return LocationModel.fromJson(
          querySnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      log.e('Error getting location: $e');
      return null;
    }
  }
}
