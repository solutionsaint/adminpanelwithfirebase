import 'package:flutter/material.dart';

import 'package:attendance_app/resources/images.dart';
import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/screens/auth/login_screen.dart';
import 'package:attendance_app/screens/auth/signup_screen.dart';
import 'package:attendance_app/themes/colors.dart';
import 'package:attendance_app/themes/fonts.dart';
import 'package:attendance_app/widgets/common/custom_elevated_button.dart';

class OptionsScreen extends StatelessWidget {
  const OptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double safeHeight = screenSize.height - padding.top - padding.bottom;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: safeHeight,
            width: screenSize.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.optionBackgroundNew),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: screenSize.width * 0.95,
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: ThemeColors.primaryShadow,
                        blurRadius: 10.0,
                        spreadRadius: 2,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 10.0),
                      Text(
                        Strings.homeText,
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.bodyLargeTitleBrownBold,
                      ),
                      const SizedBox(height: 40.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: screenSize.width * 0.4,
                            child: CustomElevatedButton(
                              text: Strings.signIn,
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => const LoginScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.4,
                            child: CustomElevatedButton(
                              text: Strings.register,
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (ctx) => const SignupScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
