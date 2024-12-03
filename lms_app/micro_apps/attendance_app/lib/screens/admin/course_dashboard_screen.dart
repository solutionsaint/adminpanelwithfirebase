import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/widgets/admin/course_dashboard_widget.dart';
import 'package:attendance_app/widgets/attendance/attendance_layout.dart';
import 'package:flutter/material.dart';

class CourseDashboardScreen extends StatelessWidget {
  const CourseDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseModel course =
        ModalRoute.of(context)?.settings.arguments as CourseModel;
    return AttendanceLayout(
      topBarText: Strings.dashBoard,
      child: CourseDashboardWidget(
        course: course,
      ),
    );
  }
}
