import 'package:flutter/material.dart';

import 'package:attendance_app/constants/enums/button_size.dart';
import 'package:attendance_app/themes/colors.dart';
import 'package:attendance_app/utils/widgets/get_elevated_button_padding.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.buttonSize,
    this.isLoading,
    this.buttonTextStyle,
  });

  final String text;
  final ButtonSize? buttonSize;
  final bool? isLoading;
  final TextStyle? buttonTextStyle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            ThemeColors.buttonGradientLeft,
            ThemeColors.buttonGradientRight
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: ThemeColors.buttonShadow,
            blurRadius: 10.4,
            offset: const Offset(0, 4),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(50),
          onTap: onPressed,
          child: Container(
            padding: getElevatedButtonPadding(buttonSize),
            alignment: Alignment.center,
            child: (isLoading != null && isLoading == true)
                ? CircularProgressIndicator(
                    color: ThemeColors.white,
                    strokeWidth: 2,
                  )
                : Text(
                    text,
                    style: buttonTextStyle ??
                        Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 18.0,
                            ),
                  ),
          ),
        ),
      ),
    );
  }
}
