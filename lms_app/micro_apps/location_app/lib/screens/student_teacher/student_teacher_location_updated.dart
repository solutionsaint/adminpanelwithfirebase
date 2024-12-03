import 'package:flutter/material.dart';
import 'package:location_app/containers/student_teacher/student_teacher_location_update_container.dart';

import 'package:location_app/resources/strings.dart';
import 'package:location_app/widgets/common/screen_layout.dart';

class StudentTeacherLocationUpdatedScreen extends StatelessWidget {
  const StudentTeacherLocationUpdatedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      topBarText: Strings.location,
      bottomText: Strings.myLocation,
      showBackButton: false,
      child: StudentTeacherLocationUpdateContainer(),
    );
  }
}
