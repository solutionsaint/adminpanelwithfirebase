import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquiry_app/core/services/firebase/firebase_storage_service.dart';
import 'package:enquiry_app/models/enquiry/enquiry_model.dart';
import 'package:enquiry_app/utils/logger/logger.dart';

class EnquiryService {
  EnquiryService._privateConstructor();
  final log = CustomLogger.getLogger('Appointments Service');

  // Static instance of the class
  static final EnquiryService _instance = EnquiryService._privateConstructor();
  static final FirebaseStorageService _firebaseStorage =
      FirebaseStorageService();

  // Factory constructor to return the static instance
  factory EnquiryService() {
    return _instance;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> createEnquiry(
    String issue,
    String subject,
    String description,
    String priority,
    String userId,
    String instituteId,
    String type,
    File? file,
  ) async {
    try {
      String enquiryId = _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('enquiries')
          .doc()
          .id;

      String? imageUrl;

      if (file != null) {
        imageUrl = await _firebaseStorage.uploadFile(
            file, 'institutes/$instituteId/enquiries/', enquiryId);
      }

      EnquiryModel enquiryModel = EnquiryModel(
        description: description,
        status: 'created',
        enquiryId: enquiryId,
        issue: issue,
        priority: priority,
        subject: subject,
        type: type,
        userId: userId,
        fileUrl: imageUrl,
        isReOpen: false,
      );

      await _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('enquiries')
          .doc(enquiryId)
          .set(
        {
          ...enquiryModel.toJson(),
        },
      );
      return enquiryId;
    } catch (e) {
      log.e('Error creating ticket: $e');
      return null;
    }
  }

  Stream<List<EnquiryModel>> getMyEnquiries(
    String userId,
    String instituteId,
  ) async* {
    try {
      // Query Firestore for enquiries with the matching userId
      Stream<QuerySnapshot> enquiriesStream = _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('enquiries')
          .where('userId', isEqualTo: userId)
          .where("status", isEqualTo: "created")
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

  Stream<List<EnquiryModel>> getMyResolvedEnquiries(
    String userId,
    String instituteId,
  ) async* {
    try {
      // Query Firestore for enquiries with the matching userId
      Stream<QuerySnapshot> enquiriesStream = await _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('enquiries')
          .where('userId', isEqualTo: userId)
          .where("status", isEqualTo: "resolved")
          .snapshots();

      // Convert each document to EnquiryModel and return as a list
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
}
