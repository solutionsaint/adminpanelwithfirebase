import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:registration_app/core/services/firebase/firebase_storage_service.dart';
import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/models/registration/student_registration_model.dart';
import 'package:registration_app/models/registration/teacher_registration_model.dart';

class RegistrationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorageService _firebaseStorage =
      FirebaseStorageService();

  Future<String> registerTeacher({
    required CourseModel course,
    required String selectedBatchDay,
    required String selectedBatchTime,
    required String registeredBy,
    required String userName,
    required String instituteId,
  }) async {
    try {
      // Generate a unique registration ID
      final DocumentReference registrationRef = _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('teachers-registrations')
          .doc();
      final String registrationId = registrationRef.id;

      // Create TeacherRegistrationModel
      final TeacherRegistrationModel registration = TeacherRegistrationModel(
        courseName: course.courseTitle,
        courseId: course.courseId,
        registrationId: registrationId,
        registeredBy: registeredBy,
        status: 'Pending',
        paymentStatus: 'Unpaid',
        imageUrl: course.imageUrl,
        registeredFor: 'self',
        userName: userName,
      );

      // Store the registration in Firestore
      await _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('teachers-registrations')
          .doc(registrationId)
          .set({
        ...registration.toJson(),
        'registrationTime': FieldValue.serverTimestamp(),
      });

      // Update the user's registered courses in Firestore
      await _firestore.collection('lms-users').doc(registeredBy).update({
        'registeredCourses': FieldValue.arrayUnion([course.courseId])
      });

      return registrationId;
    } catch (e) {
      print('Error registering teacher: $e');
      throw Exception('Failed to register teacher');
    }
  }

  Future<List<String>> registerStudent({
    required List<CourseModel> courses,
    required String registeredBy,
    required String email,
    required String userName,
    required String mobileNumber,
    required String registeredFor,
    required String instituteId,
  }) async {
    try {
      // Create a list to store registration IDs
      List<String> registrationIds = [];

      // Loop through each course in the courses list
      for (CourseModel course in courses) {
        // Generate a unique registration ID for each course
        final DocumentReference courseRegistrationRef = _firestore
            .collection('institutes')
            .doc(instituteId)
            .collection('students-registrations')
            .doc();
        final String courseRegistrationId = courseRegistrationRef.id;

        // Create StudentRegistrationModel for each course
        final StudentRegistrationModel registration = StudentRegistrationModel(
          courseName: course.courseTitle,
          courseId: course.courseId,
          registrationId: courseRegistrationId,
          registeredBy: registeredBy,
          status: 'Pending',
          paymentStatus: 'Unpaid',
          imageUrl: course.imageUrl,
          registeredFor: registeredFor,
          batchDay: course.batchDay,
          batchTime: course.batchTime!,
          email: email,
          userName: userName,
          mobileNumber: mobileNumber,
        );

        // Store the registration in Firestore
        await _firestore
            .collection('institutes')
            .doc(instituteId)
            .collection('students-registrations')
            .doc(courseRegistrationId)
            .set({
          ...registration.toJson(),
          'registrationTime': FieldValue.serverTimestamp(),
        });

        // Add the course ID to the user's registered courses in Firestore
        await _firestore.collection('lms-users').doc(registeredBy).update({
          'registeredCourses': FieldValue.arrayUnion([course.courseId])
        });

        // Add the registration ID to the list
        registrationIds.add(courseRegistrationId);
      }

      // Return all registration IDs as a comma-separated string
      return registrationIds;
    } catch (e) {
      print('Error registering student: $e');
      throw Exception('Failed to register student');
    }
  }

  Future<List<String>> registerKid({
    required List<CourseModel> courses,
    required String selectedBatchDay,
    required String selectedBatchTime,
    required String registeredBy,
    required String email,
    required String userName,
    required String mobileNumber,
    required String registeredFor,
    required String instituteId,
  }) async {
    try {
      // Create a list to store registration IDs
      List<String> registrationIds = [];

      print(registeredBy);

      // Loop through each course in the courses list
      for (CourseModel course in courses) {
        // Generate a unique registration ID for each course
        final DocumentReference courseRegistrationRef = _firestore
            .collection('institutes')
            .doc(instituteId)
            .collection('students-registrations')
            .doc();
        final String courseRegistrationId = courseRegistrationRef.id;

        // Create StudentRegistrationModel for each course
        final StudentRegistrationModel registration = StudentRegistrationModel(
          courseName: course.courseTitle,
          courseId: course.courseId,
          registrationId: courseRegistrationId,
          registeredBy: registeredBy,
          status: 'Pending',
          paymentStatus: 'Unpaid',
          imageUrl: course.imageUrl,
          registeredFor: registeredFor,
          batchDay: course.batchDay,
          batchTime: course.batchTime!,
          email: email,
          userName: userName,
          mobileNumber: mobileNumber,
        );

        // Store the registration in Firestore
        await _firestore
            .collection('institutes')
            .doc(instituteId)
            .collection('students-registrations')
            .doc(courseRegistrationId)
            .set({
          ...registration.toJson(),
          'registrationTime': FieldValue.serverTimestamp(),
        });

        // Add the course ID to the user's registered courses in Firestore
        await _firestore.collection('lms-users').doc(registeredBy).update({
          'registeredCourses': FieldValue.arrayUnion([course.courseId])
        });

        // Add the registration ID to the list
        registrationIds.add(courseRegistrationId);
      }

      // Return all registration IDs as a comma-separated string
      return registrationIds;
    } catch (e) {
      print('Error registering student: $e');
      throw Exception('Failed to register student');
    }
  }

  Future<List<StudentRegistrationModel>> getStudentRegistrationList(
      String instituteId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('students-registrations')
          .where('status', isEqualTo: 'Pending')
          .get();
      return snapshot.docs
          .map((doc) => StudentRegistrationModel.fromJson(
              doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching student registration list: $e');
      throw Exception('Failed to fetch student registration list');
    }
  }

  Future<List<TeacherRegistrationModel>> getTeacherRegistrationList(
      String instituteId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('teachers-registrations')
          .get();
      return snapshot.docs
          .map((doc) => TeacherRegistrationModel.fromJson(
              doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching teacher registration list: $e');
      throw Exception('Failed to fetch teacher registration list');
    }
  }

  Future<bool> onAcceptStudent(
    String registrationId,
    File feeReceipt,
    File applicationReceipt,
    String instituteId,
  ) async {
    try {
      String feeReceiptUrl = await _firebaseStorage.uploadFile(
          feeReceipt,
          'institutes/$instituteId/studentt-registration/$registrationId',
          'fee-receipt');
      String applicationReceiptUrl = await _firebaseStorage.uploadFile(
          applicationReceipt,
          'institutes/$instituteId/studentt-registration/$registrationId',
          'application-receipt');
      final DocumentReference studentRef = _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('students-registrations')
          .doc(registrationId);

      await studentRef.update({
        'status': 'Approved',
        'feeReceiptUrl': feeReceiptUrl,
        'applicationReceiptUrl': applicationReceiptUrl,
      });
      return true;
    } catch (e) {
      print('Error fetching teacher registration list: $e');
      return false;
    }
  }

  Future<bool> onRejectStudent(
    String registrationId,
    String instituteId,
  ) async {
    try {
      final DocumentReference studentRef = _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('students-registrations')
          .doc(registrationId);

      await studentRef.update({
        'status': 'Rejected',
      });
      return true;
    } catch (e) {
      print('Error fetching teacher registration list: $e');
      return false;
    }
  }

  Future<bool> onAcceptTeacher(
      String registrationId, String instituteId) async {
    try {
      final DocumentReference studentRef = _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('teachers-registrations')
          .doc(registrationId);

      await studentRef.update({'status': 'Approved'});
      return true;
    } catch (e) {
      print('Error fetching teacher registration list: $e');
      return false;
    }
  }

  Future<bool> onRejectTeacher(
      String registrationId, String instituteId) async {
    try {
      final DocumentReference studentRef = _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('teachers-registrations')
          .doc(registrationId);

      await studentRef.update({'status': 'Rejected'});
      return true;
    } catch (e) {
      print('Error fetching teacher registration list: $e');
      return false;
    }
  }

  Future<List<StudentRegistrationModel>> getApprovedStudentRegistrationList(
      String instituteId) async {
    try {
      final QuerySnapshot snapshot = await _firestore
          .collection('institutes')
          .doc(instituteId)
          .collection('students-registrations')
          .where('status', isEqualTo: 'Approved')
          .get();
      return snapshot.docs
          .map((doc) => StudentRegistrationModel.fromJson(
              doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print('Error fetching student registration list: $e');
      throw Exception('Failed to fetch student registration list');
    }
  }
}
