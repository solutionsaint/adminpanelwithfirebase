import 'package:flutter/material.dart';

import 'package:registration_app/constants/enums/button_size.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/screens/auth/options_screen.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/widgets/common/custom_elevated_button.dart';

class WelcomeScreenWidget extends StatelessWidget {
  const WelcomeScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                Strings.welcomeTo,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: ThemeColors.primary,
                    ),
              ),
              const SizedBox(height: 10),
              Text(
                Strings.registrationApp,
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: ThemeColors.primary,
                    ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  'Register effortlessly with our app! Secure, user-friendly, and quick. Join now to unlock exclusive features and personalized experiences.',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                        height: 1.4,
                      ),
                ),
              ),
              SizedBox(
                width: screenSize.width * 0.8,
                child: CustomElevatedButton(
                  text: Strings.getStarted,
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const OptionsScreen(),
                      ),
                    );
                  },
                  buttonSize: ButtonSize.large,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
