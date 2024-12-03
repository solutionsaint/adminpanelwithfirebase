import 'package:flutter/material.dart';

import 'package:menu_app/constants/enums/button_size.dart';
import 'package:menu_app/resources/images.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/screens/auth/options_screen.dart';
import 'package:menu_app/widgets/common/custom_elevated_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final EdgeInsets padding = MediaQuery.of(context).padding;
    final double safeHeight = screenSize.height - padding.top - padding.bottom;

    return Container(
      height: safeHeight,
      width: screenSize.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Images.welcomeBackground),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Strings.welcomeTo,
                  style: Theme.of(context).textTheme.headlineLarge!,
                ),
                const SizedBox(height: 10),
                Text(
                  Strings.menuApp,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Welcome to the Menu App! This platform allows administrators to add and manage content for the applications. Customize your app to fit your needs and streamline your operations.',
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(
                          height: 1.4,
                          fontSize: 14,
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
      ),
    );
  }
}
