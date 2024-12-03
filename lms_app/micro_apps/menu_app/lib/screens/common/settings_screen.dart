import 'package:flutter/material.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/containers/common/settings_screen_container.dart';
import 'package:menu_app/widgets/menu/menu_layout.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MenuLayout(
      showLogout: false,
      topBarText: Strings.settings,
      child: SettingsScreenContainer(),
    );
  }
}
