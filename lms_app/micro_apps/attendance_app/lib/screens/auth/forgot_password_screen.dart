import 'package:flutter/material.dart';

import 'package:attendance_app/containers/auth/login/forgot_password_container.dart';
import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/widgets/attendance/attendance_layout.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AttendanceLayout(
      topBarText: Strings.forgetYourPassword,
      showLogout: false,
      child: ForgetPasswordContainer(),
    );
  }
}
