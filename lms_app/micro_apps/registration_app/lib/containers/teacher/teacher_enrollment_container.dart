import 'package:flutter/material.dart';
import 'package:registration_app/models/registration/course_model.dart';

import 'package:registration_app/widgets/teacher/teacher_enrollment_widget.dart';

class TeacherEnrollmentContainer extends StatelessWidget {
  const TeacherEnrollmentContainer({
    super.key,
    required this.regId,
    required this.course,
  });
  final String regId;
  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return TeacherEnrollmentWidget(
      regId: regId,
      course: course,
    );
  }
}
