import 'package:flutter/material.dart';

import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/themes/fonts.dart';
import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/widgets/attendance/class_progress_widget.dart';
import 'package:attendance_app/widgets/attendance/course_detail_widget.dart';

class StudentDetailViewStudentWidget extends StatefulWidget {
  const StudentDetailViewStudentWidget({
    super.key,
    required this.course,
    required this.attendedHours,
    required this.name,
    required this.studentId,
  });

  final CourseModel course;
  final int attendedHours;
  final String name;
  final String studentId;

  @override
  State<StudentDetailViewStudentWidget> createState() =>
      _StudentDetailViewWidgetState();
}

class _StudentDetailViewWidgetState
    extends State<StudentDetailViewStudentWidget> {
  int? _attendedHours;
  @override
  void initState() {
    super.initState();
    _attendedHours = widget.attendedHours;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Row(
              children: [
                Text(
                  "Name : ",
                  style: Theme.of(context).textTheme.bodyMediumPrimary,
                ),
                Text(
                  widget.name,
                  style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                )
              ],
            ),
          ),
          CourseDetailWidget(course: widget.course),
          ClassProgressWidget(
            attenedHours: _attendedHours!,
            totalHours: widget.course.totalHours,
            buttonText: Strings.continueTheCourse,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
