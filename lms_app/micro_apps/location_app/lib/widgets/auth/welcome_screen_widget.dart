import 'package:flutter/material.dart';

import 'package:location_app/constants/enums/button_size.dart';
import 'package:location_app/resources/strings.dart';
import 'package:location_app/screens/auth/options_screen.dart';
import 'package:location_app/widgets/common/custom_elevated_button.dart';

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
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(height: 10),
              Text(
                Strings.locationApp,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Text(
                  textAlign: TextAlign.center,
                  "Discover and share locations with ease. Our app helps you find, save, and navigate to your favorite places seamlessly, with real-time updates and personalized recommendations.",
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
