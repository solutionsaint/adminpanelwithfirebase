import 'package:flutter/material.dart';

import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';

class RadioButton extends StatelessWidget {
  const RadioButton({
    super.key,
    required this.selectedOption,
    required this.onChange,
    required this.value,
  });

  final String selectedOption;
  final void Function(String? value) onChange;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio<String>(
          value: value,
          groupValue: selectedOption,
          onChanged: onChange,
          activeColor: ThemeColors.titleBrown,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleSmallTitleBrown,
        ),
      ],
    );
  }
}
