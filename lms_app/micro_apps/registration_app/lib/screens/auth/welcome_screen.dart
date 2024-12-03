import 'package:flutter/material.dart';

import 'package:registration_app/resources/images.dart';
import 'package:registration_app/widgets/auth/welcome_screen_widget.dart';

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
      child: const WelcomeScreenWidget(),
    );
  }
}
