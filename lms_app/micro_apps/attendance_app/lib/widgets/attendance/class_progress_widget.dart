import 'package:flutter/material.dart';

import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/themes/colors.dart';
import 'package:attendance_app/themes/fonts.dart';
import 'package:attendance_app/widgets/common/continue_button.dart';

class ClassProgressWidget extends StatelessWidget {
  const ClassProgressWidget({
    super.key,
    required this.totalHours,
    required this.attenedHours,
    required this.buttonText,
    this.onPressed,
  });

  final int totalHours;
  final int attenedHours;
  final String buttonText;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          Strings.className,
          style: Theme.of(context).textTheme.bodyMediumPrimary,
        ),
        Container(
          decoration: BoxDecoration(
            color: ThemeColors.white,
            border: Border.all(
              color: ThemeColors.cardBorderColor,
              width: 0.3,
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 2),
                blurRadius: 5,
                spreadRadius: 0,
                color: ThemeColors.black.withOpacity(0.1),
              )
            ],
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Strings.totalHours,
                        style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                      ),
                      _buildCircularProgress(totalHours, totalHours, context),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Strings.completedHours,
                        style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                      ),
                      _buildCircularProgress(attenedHours, totalHours, context),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ContinueButton(
                    text: buttonText,
                    onPressed: onPressed,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

Widget _buildCircularProgress(
    int completedHours, int totalHours, BuildContext context) {
  double progress = completedHours / totalHours;
  return Stack(
    alignment: Alignment.center,
    children: [
      SizedBox(
        height: 74,
        width: 74,
        child: CircularProgressIndicator(
          value: progress,
          strokeWidth: 6,
          color: ThemeColors.primary,
          backgroundColor: ThemeColors.circularProgressLightColor,
        ),
      ),
      Text(
        '$completedHours Hrs',
        style: Theme.of(context).textTheme.bodyMediumTitleBrownSemiBold,
      ),
    ],
  );
}
