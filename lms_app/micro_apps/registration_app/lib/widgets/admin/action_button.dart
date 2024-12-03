import 'package:flutter/material.dart';

import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';
import 'package:registration_app/widgets/common/svg_lodder.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.text,
    required this.icon,
    required this.onTap,
    this.width,
    this.height,
  });

  final String text;
  final String icon;
  final void Function() onTap;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: ThemeColors.white,
          borderRadius: BorderRadius.circular(50),
          border: Border.all(
            color: ThemeColors.primary,
            width: 0.3,
          ),
          boxShadow: [
            BoxShadow(
              color: ThemeColors.black.withOpacity(0.25),
              blurRadius: 2.15,
              spreadRadius: 0,
              offset: const Offset(0, 0.54),
            )
          ],
        ),
        padding: const EdgeInsets.only(left: 10, right: 5, top: 5, bottom: 5),
        width: width ?? 80,
        height: height ?? 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style:
                  Theme.of(context).textTheme.displayMediumTitleBrownSemiBold,
            ),
            SVGLoader(image: icon)
          ],
        ),
      ),
    );
  }
}
