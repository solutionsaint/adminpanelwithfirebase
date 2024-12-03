import 'package:flutter/material.dart';
import 'package:registration_app/core/services/firebase/firebase_auth_service.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/screens/auth/login_screen.dart';
import 'package:registration_app/utils/show_snackbar.dart';
import 'package:registration_app/widgets/login/forgot_password_widget.dart';

class ForgetPasswordContainer extends StatefulWidget {
  const ForgetPasswordContainer({super.key});

  @override
  State<ForgetPasswordContainer> createState() =>
      _ForgetPasswordContainerState();
}

class _ForgetPasswordContainerState extends State<ForgetPasswordContainer> {
  bool _isLoading = false;
  final FirebaseAuthService _authService = FirebaseAuthService();

  void onForgetPassword(String email) async {
    setState(() {
      _isLoading = true;
    });
    final response = await _authService.sendPasswordResetEmail(email);
    setState(() {
      _isLoading = false;
    });
    if (response) {
      showSnackbar(context, Strings.passwordResetEmailSent);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      showSnackbar(context, Strings.anErrorOccurredPleaseTryAgainLater);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ForgetPasswordForm(
      isLoading: _isLoading,
      onForgetPassword: onForgetPassword,
    );
  }
}
