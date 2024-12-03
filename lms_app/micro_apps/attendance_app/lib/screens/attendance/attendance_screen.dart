import 'package:attendance_app/models/courses/course_model.dart';
import 'package:flutter/material.dart';

import 'package:attendance_app/containers/attendance/attendance_container.dart';
import 'package:attendance_app/widgets/attendance/attendance_layout.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseModel course =
        ModalRoute.of(context)!.settings.arguments as CourseModel;

    return AttendanceLayout(
      bottomText: "Course",
      topBarText: "Attendance",
      child: AttendanceContainer(course: course),
    );
  }
}
