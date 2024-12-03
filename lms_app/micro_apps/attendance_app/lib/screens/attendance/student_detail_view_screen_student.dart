import 'package:flutter/material.dart';

import 'package:attendance_app/widgets/attendance/student_detail_view_student_widget.dart';
import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/widgets/attendance/attendance_layout.dart';

class StudentDetailViewScreenStudent extends StatelessWidget {
  const StudentDetailViewScreenStudent({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final CourseModel course = arguments['course'] as CourseModel;
    final int attendedHours = arguments['attendedHours'] as int;
    final String name = arguments['studentName'] as String;
    final String studentId = arguments['studentId'] as String;
    return AttendanceLayout(
      topBarText: Strings.studentDetailView,
      child: StudentDetailViewStudentWidget(
        course: course,
        attendedHours: attendedHours,
        name: name,
        studentId: studentId,
      ),
    );
  }
}
