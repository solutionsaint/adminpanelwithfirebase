import 'package:flutter/material.dart';

import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/widgets/attendance/attendance_layout.dart';
import 'package:attendance_app/widgets/attendance/student_course_dashboard_widget.dart';

class StudentCourseDashboardScreen extends StatelessWidget {
  const StudentCourseDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseModel course =
        ModalRoute.of(context)?.settings.arguments as CourseModel;
    return AttendanceLayout(
      topBarText: Strings.dashBoard,
      child: StudentCourseDashboardWidget(
        course: course,
      ),
    );
  }
}
