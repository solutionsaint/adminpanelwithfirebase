import 'package:flutter/material.dart';
import 'package:registration_app/screens/admin/reception_enquiry_detail_screen.dart';
import 'package:registration_app/screens/admin/reception_enquiry_screen.dart';

import 'package:registration_app/screens/admin/registration_list_screen.dart';
import 'package:registration_app/screens/admin/resolved_enquiry_screen.dart';
import 'package:registration_app/screens/admin/student_list_screen.dart';
import 'package:registration_app/screens/admin/teacher_list_screen.dart';
import 'package:registration_app/screens/admin/upload_student_receipt_screen.dart';

class AdminRoutes {
  const AdminRoutes._();

  static const String registrationList = '/regstration-list';
  static const String studentList = '/student-list';
  static const String teacherList = '/teacher-list';
  static const String uploadReceipt = '/upload-receipt';
  static const String receptionEnquiry = '/reception-enquiry';
  static const String receptionEnquiryDetail = '/reception-enquiry-detail';
  static const String resolvedEnquiryScreen = '/resolved-enquiry-screen';

  static Map<String, WidgetBuilder> get buildAdminRoutes {
    return {
      registrationList: (context) => const RegistrationListScreen(),
      studentList: (context) => const StudentListScreen(),
      teacherList: (context) => const TeacherListScreen(),
      uploadReceipt: (context) => const UploadStudentReceiptScreen(),
      receptionEnquiry: (context) => const ReceptionEnquiryScreen(),
      receptionEnquiryDetail: (context) => const ReceptionEnquiryDetailScreen(),
      resolvedEnquiryScreen: (context) => const ResolvedEnquiryScreen(),
    };
  }

  static String get initialAdminRoute {
    return AdminRoutes.registrationList;
  }
}
