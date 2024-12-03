import 'package:flutter/material.dart';

import 'package:registration_app/containers/teacher/teacher_item_detail_container.dart';
import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';

class TeacherItemDetailScreen extends StatelessWidget {
  const TeacherItemDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final course = ModalRoute.of(context)!.settings.arguments as CourseModel;

    return ScreenLayout(
      topBarText: Strings.item,
      child: TeacherItemDetailContainer(course: course),
    );
  }
}
