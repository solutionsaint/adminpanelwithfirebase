import 'package:flutter/material.dart';

import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/widgets/student/student_item_detail_widget.dart';

class StudentItemDetailContainer extends StatelessWidget {
  const StudentItemDetailContainer({super.key, required this.course});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return StudentItemDetailWidget(course: course);
  }
}
