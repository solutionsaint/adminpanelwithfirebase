import 'package:flutter/material.dart';

import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/utils/error/show_snackbar.dart';
import 'package:attendance_app/models/courses/display_attendance_model.dart';
import 'package:attendance_app/core/services/attendance/attendance_service.dart';
import 'package:attendance_app/widgets/admin/attendance_changes_widget.dart';

class AttendanceChangesContainer extends StatefulWidget {
  const AttendanceChangesContainer({
    super.key,
    required this.courseId,
    required this.studentId,
  });

  final String courseId;
  final String studentId;

  @override
  State<AttendanceChangesContainer> createState() =>
      _AttendanceChangesContainerState();
}

class _AttendanceChangesContainerState
    extends State<AttendanceChangesContainer> {
  AttendanceService attendanceService = AttendanceService();
  bool _isLoading = true;
  List<DisplayAttendanceModel> attendances = [];
  @override
  void initState() {
    super.initState();
    fetchAttendances();
  }

  void fetchAttendances() async {
    attendances = await attendanceService.getStudentAttendance(
        widget.studentId, widget.courseId);
    setState(() {
      _isLoading = false;
    });
  }

  void onUpdateAttendance(
      List<DisplayAttendanceModel> updatedAttendances) async {
    setState(() {
      _isLoading = true;
    });
    final int response = await attendanceService.updateStudentAttendance(
      widget.studentId,
      widget.courseId,
      updatedAttendances,
    );
    Navigator.pop(context, response);
    showSnackbar(context, Strings.attendanceUpdatedSuccessfully);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : AttendanceChangesWidget(
            isLoading: _isLoading,
            attendances: attendances,
            onUpdateAttendance: onUpdateAttendance,
          );
  }
}
