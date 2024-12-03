import 'package:flutter/material.dart';
import 'package:registration_app/containers/auth/login/role_type_selection_container.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';

class RoleTypeSelectionScreen extends StatelessWidget {
  const RoleTypeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      showInstituteName: false,
      topBarText: 'Select Role Type',
      showBackButton: false,
      child: RoleTypeSelectionContainer(),
    );
  }
}
