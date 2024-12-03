import 'package:attendance_app/screens/admin/attendance_changes_screen.dart';
import 'package:attendance_app/screens/admin/course_dashboard_screen.dart';
import 'package:attendance_app/screens/admin/item_detail_screen.dart';
import 'package:attendance_app/screens/admin/items_list_screen.dart';
import 'package:attendance_app/screens/admin/reception_enquiry_detail_screen.dart';
import 'package:attendance_app/screens/admin/reception_enquiry_screen.dart';
import 'package:attendance_app/screens/admin/resolved_enquiry_screen.dart';
import 'package:attendance_app/screens/admin/student_detail_view_screen.dart';
import 'package:flutter/material.dart';

class AdminRoutes {
  const AdminRoutes._();

  static const String itemList = "item-list";
  static const String itemDetail = "item-detail";
  static const String receptionEnquiry = '/reception-enquiry';
  static const String receptionEnquiryDetail = '/reception-enquiry-detail';
  static const String courseDashboard = "/course-dashboard";
  static const String studentDetailView = "/student-detail-view";
  static const String attendanceChanges = '/attendance-changes';
  static const String resolvedEnquiryScreen = '/resolved-enquiry-screen';

  static Map<String, WidgetBuilder> get buildAdminRoutes {
    return {
      itemList: (context) => const ItemsListScreen(),
      itemDetail: (context) => const ItemDetailScreen(),
      receptionEnquiry: (context) => const ReceptionEnquiryScreen(),
      receptionEnquiryDetail: (context) => const ReceptionEnquiryDetailScreen(),
      courseDashboard: (context) => const CourseDashboardScreen(),
      studentDetailView: (context) => const StudentDetailViewScreen(),
      attendanceChanges: (context) => const AttendanceChangesScreen(),
      resolvedEnquiryScreen: (context) => const ResolvedEnquiryScreen(),
    };
  }

  static String get initialRoute {
    return AdminRoutes.itemList;
  }
}
