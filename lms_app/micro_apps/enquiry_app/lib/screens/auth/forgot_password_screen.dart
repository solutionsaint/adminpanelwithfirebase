import 'package:enquiry_app/containers/auth/login/forgot_password_container.dart';
import 'package:enquiry_app/resources/strings.dart';
import 'package:enquiry_app/widgets/common/screen_layout.dart';
import 'package:flutter/material.dart';

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
