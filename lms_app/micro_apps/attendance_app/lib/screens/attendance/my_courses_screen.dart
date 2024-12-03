import 'package:flutter/material.dart';

import 'package:attendance_app/containers/attendance/my_courses_container.dart';
import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/widgets/attendance/attendance_layout.dart';

class MyCoursesScreen extends StatelessWidget {
  const MyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AttendanceLayout(
      topBarText: Strings.attendance,
      bottomText: Strings.myCourses,
      showBackButton: false,
      child: MyCoursesContainer(),
    );
  }
}
