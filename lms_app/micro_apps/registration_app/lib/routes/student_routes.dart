import 'package:flutter/material.dart';

import 'package:registration_app/screens/student/cart_screen.dart';
import 'package:registration_app/screens/student/face_recognition_screen.dart';
import 'package:registration_app/screens/student/kid_enrollment_screen.dart';
import 'package:registration_app/screens/student/kid_registration_screen.dart';
import 'package:registration_app/screens/student/someone_face_recognition.dart';
import 'package:registration_app/screens/student/student_access_code_screen.dart';
import 'package:registration_app/screens/student/student_enrollment_screen.dart';
import 'package:registration_app/screens/student/student_item_detail_screen.dart';
import 'package:registration_app/screens/student/student_item_list_screen.dart';
import 'package:registration_app/screens/student/student_register_screen.dart';

class StudentRoutes {
  const StudentRoutes._();

  static const String accessCode = 'access-code';
  static const String itemList = '/';
  static const String itemDetail = '/item-detail';
  static const String cart = '/cart';
  static const String register = '/register';
  static const String enrollment = '/enrollment';
  static const String kidRegistration = '/kid-registration';
  static const String faceRecognition = '/face-recognition';
  static const String kidEnrollment = '/kid-enrollment';
  static const String someoneFaceRecognition = '/someone-face-recognition';

  static Map<String, WidgetBuilder> get buildStudentRoutes {
    return {
      accessCode: (context) => const StudentAccessCodeScreen(),
      itemList: (context) => const StudentItemListScreen(),
      itemDetail: (context) => const StudentItemDetailScreen(),
      cart: (context) => const CartScreen(),
      register: (context) => const StudentRegisterScreen(),
      enrollment: (context) => const StudentEnrollmentScreen(),
      kidRegistration: (context) => const KidRegistrationScreen(),
      faceRecognition: (ctx) => const FaceRecognitionScreen(),
      kidEnrollment: (ctx) => const KidEnrollmentScreen(),
      someoneFaceRecognition: (ctx) => const SomeoneFaceRecognition(),
    };
  }

  static String get initialStudentRoute {
    return StudentRoutes.accessCode;
  }
}
