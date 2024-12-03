import 'package:flutter/material.dart';

import 'package:registration_app/containers/teacher/teacher_register_container.dart';
import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';

class TeacherRegisterScreen extends StatelessWidget {
  const TeacherRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final course = arguments['course'] as CourseModel;
    final batchDay = arguments['batchDay'] as String;
    final batchTime = arguments['batchTime'] as String;

    return ScreenLayout(
      topBarText: Strings.register,
      child: TeacherRegisterContainer(
        course: course,
        selectedBatchDay: batchDay,
        selectedBatchTime: batchTime,
      ),
    );
  }
}
