import 'package:flutter/material.dart';

import 'package:registration_app/containers/admin/teacher_list_container.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';

class TeacherListScreen extends StatelessWidget {
  const TeacherListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      topBarText: Strings.teacher,
      child: TeacherListContainer(),
    );
  }
}
