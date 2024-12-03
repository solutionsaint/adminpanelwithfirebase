import 'package:flutter/material.dart';

import 'package:enquiry_app/containers/student_teacher/settings_screen_container.dart';
import 'package:enquiry_app/resources/strings.dart';
import 'package:enquiry_app/widgets/common/screen_layout.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      showLogout: false,
      topBarText: Strings.settings,
      child: SettingsScreenContainer(),
    );
  }
}
