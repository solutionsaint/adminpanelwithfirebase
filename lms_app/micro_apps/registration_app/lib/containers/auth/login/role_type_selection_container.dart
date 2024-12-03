import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/screens/student/student_app.dart';
import 'package:registration_app/screens/teacher/teacher_app.dart';
import 'package:registration_app/utils/show_snackbar.dart';
import 'package:registration_app/widgets/auth/role_type_selection_widget.dart';

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
    final result = await authProvider.updateUserRoleType(
      roleType,
      authProvider.currentUser?.uid ?? '',
    );

    if (result) {
      // authProvider.setUserRoleType(roleType);
      if (roleType == 'Student') {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const StudentApp()),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const TeacherApp()),
          (route) => false,
        );
      }
    } else {
      showSnackbar(context, 'Failed to update role type');
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
