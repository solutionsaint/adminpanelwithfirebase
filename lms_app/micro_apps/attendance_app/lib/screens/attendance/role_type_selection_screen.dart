import 'package:flutter/material.dart';

import 'package:attendance_app/containers/attendance/role_type_selection_container.dart';
import 'package:attendance_app/widgets/attendance/attendance_layout.dart';

class RoleTypeSelectionScreen extends StatelessWidget {
  const RoleTypeSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AttendanceLayout(
      showInstituteName: false,
      topBarText: 'Select Role Type',
      showBackButton: false,
      child: RoleTypeSelectionContainer(),
    );
  }
}
