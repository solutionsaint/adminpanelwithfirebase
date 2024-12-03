import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:attendance_app/core/services/attendance/attendance_service.dart';
import 'package:attendance_app/widgets/attendance/attendance_widget.dart';
import 'package:attendance_app/models/courses/course_model.dart';

class AttendanceContainer extends StatefulWidget {
  const AttendanceContainer({
    super.key,
    required this.course,
  });

  final CourseModel course;

  @override
  State<AttendanceContainer> createState() => _ItemDetailContainerState();
}

class _ItemDetailContainerState extends State<AttendanceContainer> {
  AttendanceService attendanceService = AttendanceService();
  Map<String, bool> studentsAttendanceStatus = {};
  Map<String, bool> teachersAttendanceStatus = {};
  bool isLoading = false;
  String _date = DateFormat('ddMMyyyy').format(DateTime.now());
  String _displayFormatDate = DateFormat('dd/MM/yyyy').format(DateTime.now());

  @override
  void initState() {
    super.initState();
    fetchAttendance(_date, _displayFormatDate);
  }

  void fetchAttendance(String date, String displayFormatDate) async {
    setState(() {
      isLoading = true;
    });

    Map<String, bool> attendanceStatus = {
      for (var student in widget.course.students!) student.keys.first: false,
    };
    Map<String, bool> teachersAttendanceStatus = {
      for (var teacher in widget.course.teachers!) teacher.keys.first: false,
    };
    studentsAttendanceStatus = await attendanceService.getAttendance(
      widget.course.courseId,
      date,
      attendanceStatus,
    );
    teachersAttendanceStatus = await attendanceService.getTeachersAttendance(
      widget.course.courseId,
      date,
      teachersAttendanceStatus,
    );
    setState(() {
      _date = date;
      isLoading = false;
      _displayFormatDate = displayFormatDate;
      this.teachersAttendanceStatus = teachersAttendanceStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : AttendanceWidget(
            teachersAttendanceStatus: teachersAttendanceStatus,
            displayFormatDate: _displayFormatDate,
            course: widget.course,
            studentsAttendanceStatus: studentsAttendanceStatus,
            fetchAttendance: fetchAttendance,
          );
  }
}
