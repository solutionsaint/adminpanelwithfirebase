import 'package:flutter/material.dart';

import 'package:registration_app/containers/teacher/teacher_enrollment_container.dart';
import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';

class TeacherEnrollmentScreen extends StatelessWidget {
  const TeacherEnrollmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String regId = args['registrationId'];
    final CourseModel course = args['course'];

    return ScreenLayout(
      topBarText: Strings.enrollmentInitiated,
      child: TeacherEnrollmentContainer(regId: regId, course: course),
    );
  }
}
