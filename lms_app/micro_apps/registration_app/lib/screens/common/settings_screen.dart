import 'package:flutter/material.dart';
import 'package:registration_app/containers/common/settings_screen_container.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      showLogout: false,
      topBarText: Strings.settings,
      showInstituteName: false,
      child: SettingsScreenContainer(),
    );
  }
}
