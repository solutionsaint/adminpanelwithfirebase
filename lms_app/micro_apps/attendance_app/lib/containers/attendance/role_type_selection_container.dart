import 'package:attendance_app/providers/auth_provider.dart';
import 'package:attendance_app/screens/attendance/access_code_screen.dart';
import 'package:attendance_app/screens/attendance/face_recognition_screen.dart';
import 'package:attendance_app/widgets/attendance/role_type_selection_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoleTypeSelectionContainer extends StatefulWidget {
  const RoleTypeSelectionContainer({super.key});

  @override
  State<RoleTypeSelectionContainer> createState() =>
      _RoleTypeSelectionContainerState();
}

class _RoleTypeSelectionContainerState
    extends State<RoleTypeSelectionContainer> {
  bool _isLoading = false;

  Future<void> _onSubmit(String roleType) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      _isLoading = true;
    });

    authProvider.setUserRoleType(roleType);
    if (roleType == 'Student') {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const FaceRecognitionScreen()),
        (route) => false,
      );
    } else {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AccessCodeScreen()),
        (route) => false,
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return RoleTypeSelectionWidget(
      isLoading: _isLoading,
      onSubmit: _onSubmit,
    );
  }
}
