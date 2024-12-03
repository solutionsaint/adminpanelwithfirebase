import 'package:attendance_app/core/services/attendance/attendance_service.dart';
import 'package:flutter/material.dart';

import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/widgets/admin/item_detail_widget.dart';
import 'package:intl/intl.dart';

class ItemDetailContainer extends StatefulWidget {
  const ItemDetailContainer({
    super.key,
    required this.course,
  });

  final CourseModel course;

  @override
  State<ItemDetailContainer> createState() => _ItemDetailContainerState();
}

class _ItemDetailContainerState extends State<ItemDetailContainer> {
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

  Future<bool> onMarkAttendance(
    Map<String, bool> studentsAttendanceStatus,
    Map<String, bool> teachersAttendanceStatus,
  ) async {
    print(teachersAttendanceStatus);
    try {
      final bool response = await attendanceService.markAttendance(
        studentsAttendanceStatus,
        teachersAttendanceStatus,
        widget.course.courseId,
        _date,
      );
      if (response) {
        setState(() {
          studentsAttendanceStatus = studentsAttendanceStatus;
          teachersAttendanceStatus = teachersAttendanceStatus;
        });
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ItemDetailWidget(
            displayFormatDate: _displayFormatDate,
            course: widget.course,
            onMarkAttendance: onMarkAttendance,
            teachersAttendanceStatus: teachersAttendanceStatus,
            studentsAttendanceStatus: studentsAttendanceStatus,
            fetchAttendance: fetchAttendance,
          );
  }
}
