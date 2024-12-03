import 'package:flutter/material.dart';
import 'package:menu_app/containers/auth/login/forgot_password_container.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/widgets/menu/menu_layout.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MenuLayout(
      topBarText: Strings.forgetYourPassword,
      showLogout: false,
      child: ForgetPasswordContainer(),
    );
  }
}
