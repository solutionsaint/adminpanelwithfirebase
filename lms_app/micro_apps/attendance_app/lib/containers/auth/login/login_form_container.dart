import 'package:attendance_app/constants/constants.dart';
import 'package:attendance_app/constants/enums/user_role_enum.dart';
import 'package:attendance_app/models/auth/auth_model.dart';
import 'package:attendance_app/providers/auth_provider.dart';
import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/screens/admin/admin_app.dart';
import 'package:attendance_app/screens/attendance/app.dart';
import 'package:attendance_app/utils/error/show_snackbar.dart';
import 'package:attendance_app/utils/shared_preference/shared_preference.dart';
import 'package:attendance_app/widgets/login/login_form_widget.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class LoginFormContainer extends StatefulWidget {
  const LoginFormContainer({super.key});

  @override
  State<LoginFormContainer> createState() => _LoginFormContainerState();
}

class _LoginFormContainerState extends State<LoginFormContainer> {
  bool _isLoading = false;
  bool _isprefLoading = false;
  String? existingPassword;

  Future<void> onSignIn(
      String userEmail, String userPassword, bool isGoogle) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    setState(() {
      _isLoading = true;
    });

    final AuthModel user;
    if (isGoogle) {
      user = await authProvider.signInWithGoogle();
    } else {
      user = await authProvider.signIn(userEmail, userPassword);
    }

    if (user.error) {
      if (context.mounted) {
        showSnackbar(context, user.message);
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      if (!user.isEmailVerified) {
        showSnackbar(context, Strings.pleaseVerifyYourEmail);
        setState(() {
          _isLoading = false;
        });
        return;
      }
      if (authProvider.currentUser!.changeEmail!.isNotEmpty) {
        final response = await authProvider.changeDBEmail();
        if (!response) {
          showSnackbar(context, Strings.updateEmailFailed);
          return;
        }
      }
      final loggedInStatuses = await SharedPreferencesUtils().getMapPrefs(
        constants.loggedInStatusFlag,
      );
      await SharedPreferencesUtils()
          .addMapPrefs(passwordConstants.passwordFlag, {
        "password": userPassword,
      });
      if (loggedInStatuses.value == null ||
          loggedInStatuses.value[user.userId] == null ||
          loggedInStatuses.value[user.userId] == false) {
        final Map<String, dynamic> newLoggedStatus = {
          if (loggedInStatuses.value != null) ...loggedInStatuses.value,
          user.userId: true,
        };
        await SharedPreferencesUtils().addMapPrefs(
          constants.loggedInStatusFlag,
          newLoggedStatus,
        );
      }
      setState(() {
        _isLoading = false;
      });
      if (context.mounted) {
        if (user.role == UserRoleEnum.admin.roleName) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const AdminApp(),
            ),
            (Route<dynamic> route) => false,
          );
        } else {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const StudentTeacherAttencanceApp(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      }
    }
  }

  void checkExistingPassword() async {
    setState(() {
      _isprefLoading = true;
    });
    final passwordStatus = await SharedPreferencesUtils().getMapPrefs(
      passwordConstants.passwordFlag,
    );
    setState(() {
      existingPassword = passwordStatus.value != null
          ? passwordStatus.value['password']
          : null;
      _isprefLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    checkExistingPassword();
  }

  @override
  Widget build(BuildContext context) {
    return _isprefLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : LoginFormWidget(
            isLoading: _isLoading,
            onSignIn: onSignIn,
            existingPassword: existingPassword,
          );
  }
}
