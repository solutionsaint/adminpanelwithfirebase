import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:attendance_app/models/enquiry/enquiry_model.dart';
import 'package:attendance_app/utils/logger/logger.dart';

class EnquiryService {
  EnquiryService._privateConstructor();
  final log = CustomLogger.getLogger('Appointments Service');

  // Static instance of the class
  static final EnquiryService _instance = EnquiryService._privateConstructor();

  // Factory constructor to return the static instance
  factory EnquiryService() {
    return _instance;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<EnquiryModel>> getEnquiries(String accessId) async* {
    try {
      // Create a stream of enquiries
      Stream<QuerySnapshot> enquiriesStream = _firestore
          .collection('institutes')
          .doc(accessId)
          .collection('enquiries')
          .where("status", isNotEqualTo: "resolved")
          .where("type", isEqualTo: "Attendance")
          .snapshots();

      // Yield enquiries as they come in
      await for (QuerySnapshot querySnapshot in enquiriesStream) {
        List<EnquiryModel> enquiries = querySnapshot.docs.map((doc) {
          return EnquiryModel.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();

        yield enquiries;
      }
    } catch (e) {
      log.e('Error fetching user enquiries: $e');
      yield [];
    }
  }

  Stream<List<EnquiryModel>> getResolvedEnquiries(String accessId) async* {
    try {
      // Create a stream of enquiries
      Stream<QuerySnapshot> enquiriesStream = _firestore
          .collection('institutes')
          .doc(accessId)
          .collection('enquiries')
          .where("status", isEqualTo: "resolved")
          .where("type", isEqualTo: "Attendance")
          .snapshots();

      // Yield enquiries as they come in
      await for (QuerySnapshot querySnapshot in enquiriesStream) {
        List<EnquiryModel> enquiries = querySnapshot.docs.map((doc) {
          return EnquiryModel.fromJson(doc.data() as Map<String, dynamic>);
        }).toList();

        yield enquiries;
      }
    } catch (e) {
      log.e('Error fetching user enquiries: $e');
      yield [];
    }
  }

  Future<bool> resolveEnquiry(String enquiryId, String accessId) async {
    try {
      // Update the enquiry status to "resolved"
      await _firestore
          .collection('institutes')
          .doc(accessId)
          .collection('enquiries')
          .doc(enquiryId)
          .update({'status': 'resolved'});

      log.i('Enquiry $enquiryId resolved successfully');
      return true;
    } catch (e) {
      log.e('Error resolving enquiry: $e');
      return false;
    }
  }
}
