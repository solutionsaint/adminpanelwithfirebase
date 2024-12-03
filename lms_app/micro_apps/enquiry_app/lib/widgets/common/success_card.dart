import 'package:flutter/material.dart';

import 'package:enquiry_app/resources/strings.dart';
import 'package:enquiry_app/themes/colors.dart';
import 'package:enquiry_app/themes/fonts.dart';
import 'package:enquiry_app/widgets/common/icon_text_button.dart';
import 'package:enquiry_app/widgets/common/svg_lodder.dart';
import 'package:enquiry_app/resources/icons.dart' as icons;

class SuccessCard extends StatelessWidget {
  const SuccessCard(
      {super.key, required this.text, required this.onPress, this.content});

  final void Function() onPress;
  final String text;
  final List<String>? content;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: screenSize.width * 0.9,
          padding: const EdgeInsets.symmetric(
            vertical: 16.0,
            horizontal: 10,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: ThemeColors.successCardShadow,
                blurRadius: 10.1,
                spreadRadius: 0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              Text(
                Strings.successfully,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLargeTitleBrownBold,
              ),
              const SizedBox(height: 10.0),
              Text(
                text,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmallTitleBrown,
              ),
              const SizedBox(height: 20.0),
              const SVGLoader(
                image: icons.Icons.successIcon,
                width: 50,
                height: 50,
              ),
              const SizedBox(height: 20.0),
              if (content != null)
                ...content!.map(
                  (item) {
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              Strings.registrationNo,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMediumTitleBrownSemiBold
                                  .copyWith(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Text(
                              item,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMediumPrimarySemiBold
                                  .copyWith(
                                    fontSize: 14,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              SizedBox(
                height: 40,
                width: screenSize.width * 0.4,
                child: IconTextButton(
                  text: Strings.ok,
                  onPressed: onPress,
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
    );
  }
}
