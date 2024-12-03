import 'package:flutter/material.dart';
import 'package:registration_app/models/registration/course_model.dart';

import 'package:registration_app/widgets/teacher/teacher_item_detail_widget.dart';

class TeacherItemDetailContainer extends StatelessWidget {
  const TeacherItemDetailContainer({super.key, required this.course});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return TeacherItemDetailWidget(course: course);
  }
}
