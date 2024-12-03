import 'package:flutter/material.dart';
import 'package:location_app/containers/auth/login/forgot_password_container.dart';
import 'package:location_app/resources/strings.dart';
import 'package:location_app/widgets/common/screen_layout.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      topBarText: Strings.forgetYourPassword,
      showLogout: false,
      child: ForgetPasswordContainer(),
    );
  }
}
