import 'package:attendance_app/containers/admin/attendance_changes_container.dart';
import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/widgets/attendance/attendance_layout.dart';
import 'package:flutter/material.dart';

class AttendanceChangesScreen extends StatelessWidget {
  const AttendanceChangesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final String courseId = arguments['courseId'];
    final String studentId = arguments['studentId'];

    return AttendanceLayout(
      topBarText: Strings.attendanceChanges,
      child: AttendanceChangesContainer(
        courseId: courseId,
        studentId: studentId,
      ),
    );
  }
}
