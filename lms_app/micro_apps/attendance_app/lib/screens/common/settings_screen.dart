import 'package:flutter/material.dart';

import 'package:attendance_app/containers/common/settings_screen_container.dart';
import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/widgets/attendance/attendance_layout.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AttendanceLayout(
      showLogout: false,
      topBarText: Strings.settings,
      showInstituteName: false,
      child: SettingsScreenContainer(),
    );
  }
}
