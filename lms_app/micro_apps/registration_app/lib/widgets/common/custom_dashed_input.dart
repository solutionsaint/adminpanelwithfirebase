import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';
import 'package:registration_app/resources/icons.dart' as icons;
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/widgets/common/svg_lodder.dart';

class CustomDashedInput extends StatelessWidget {
  final String text;
  final Function() onTap;

  const CustomDashedInput({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: ThemeColors.primary,
      borderType: BorderType.RRect,
      radius: const Radius.circular(10),
      dashPattern: const [8, 4],
      strokeWidth: 2,
      padding: const EdgeInsets.all(0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
            decoration: BoxDecoration(
              color: ThemeColors.primary.withOpacity(0.1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 30,
                  height: 30,
                  child: const SVGLoader(image: icons.Icons.addFile),
                ),
                const SizedBox(width: 10),
                Text(
                  text,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
