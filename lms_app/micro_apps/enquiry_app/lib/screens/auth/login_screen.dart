import 'package:enquiry_app/containers/auth/login/login_form_container.dart';
import 'package:enquiry_app/resources/images.dart';
import 'package:enquiry_app/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:enquiry_app/themes/fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    // final EdgeInsets padding = MediaQuery.of(context).padding;
    // final double safeHeight = screenSize.height - padding.top - padding.bottom;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenSize.height,
          width: screenSize.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.loginBackgroundPng),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 70),
              child: Column(
                children: [
                  Column(
                    children: [
                      Text(
                        Strings.signIn,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(fontSize: 32.0),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        Strings.enterSignInDetails,
                        style: Theme.of(context)
                            .textTheme
                            .displayMediumSemiBold
                            .copyWith(fontSize: 15.0),
                      ),
                    ],
                  ),
                  const LoginFormContainer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
