import 'package:flutter/material.dart';

import 'package:registration_app/containers/student/student_register_container.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';

class StudentRegisterScreen extends StatelessWidget {
  const StudentRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      topBarText: Strings.register,
      child: StudentRegisterContainer(),
    );
  }
}
