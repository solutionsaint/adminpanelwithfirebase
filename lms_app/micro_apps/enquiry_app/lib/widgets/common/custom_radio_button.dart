import 'package:enquiry_app/themes/fonts.dart';
import 'package:flutter/material.dart';

import 'package:enquiry_app/themes/colors.dart';

class CustomRadioButton extends StatelessWidget {
  final String text;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const CustomRadioButton({
    super.key,
    required this.text,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: ThemeColors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(1, 2.5),
            blurRadius: 9,
            spreadRadius: 0,
            color: ThemeColors.black.withOpacity(0.1),
          ),
        ],
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.displayMediumPrimary,
          ),
          Transform.scale(
            scale: 0.75,
            child: Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: ThemeColors.titleBrown,
              visualDensity: VisualDensity.compact,
            ),
          ),
        ],
      ),
    );
  }
}
