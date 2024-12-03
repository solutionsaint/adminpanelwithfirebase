import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:registration_app/utils/logger/logger.dart';

class FaceRecognitionFirebaseService {
  FaceRecognitionFirebaseService._privateConstructor();
  final log = CustomLogger.getLogger('Face Recognition Service');

  // Static instance of the class
  static final FaceRecognitionFirebaseService _instance =
      FaceRecognitionFirebaseService._privateConstructor();

  // Factory constructor to return the static instance
  factory FaceRecognitionFirebaseService() {
    return _instance;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> saveFaceRecognitionFlag(String userId) async {
    try {
      DocumentReference userDoc =
          _firestore.collection('lms-users').doc(userId);

      await userDoc.update({
        'isFaceRecognized': true,
      });

      return true;
    } catch (e) {
      log.e('Error updating isFaceRecognized flag: $e');
      return false;
    }
  }
}
