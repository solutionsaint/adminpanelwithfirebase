import 'package:enquiry_app/resources/images.dart';
import 'package:enquiry_app/resources/strings.dart';
import 'package:enquiry_app/screens/auth/login_screen.dart';
import 'package:enquiry_app/themes/colors.dart';
import 'package:enquiry_app/widgets/common/icon_text_button.dart';
import 'package:enquiry_app/widgets/common/svg_lodder.dart';
import 'package:flutter/material.dart';
import 'package:enquiry_app/themes/fonts.dart';
import 'package:enquiry_app/resources/icons.dart' as icons;

class VerificationSuccessfulScreen extends StatelessWidget {
  const VerificationSuccessfulScreen({super.key});

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
              image: AssetImage(Images.optionBackgroundNew),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenSize.width * 0.92,
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
                      Strings.verifyYourEmail,
                      textAlign: TextAlign.center,
                      style:
                          Theme.of(context).textTheme.bodyLargeTitleBrownBold,
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      Strings.verifiedText,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleSmallTitleBrown,
                    ),
                    const SizedBox(height: 20.0),
                    const SVGLoader(
                      image: icons.Icons.successIcon,
                      width: 60,
                      height: 60,
                    ),
                    const SizedBox(height: 20.0),
                    SizedBox(
                      height: 40,
                      width: screenSize.width * 0.4,
                      child: IconTextButton(
                        text: Strings.ok,
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (ctx) => const LoginScreen(),
                            ),
                          );
                        },
                        color: ThemeColors.cardColor,
                        iconHorizontalPadding: 0,
                        buttonTextStyle:
                            Theme.of(context).textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
