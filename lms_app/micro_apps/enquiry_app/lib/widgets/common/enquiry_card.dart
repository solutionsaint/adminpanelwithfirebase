import 'package:flutter/material.dart';

import 'package:enquiry_app/themes/colors.dart';
import 'package:enquiry_app/themes/fonts.dart';

class EnquiryCard extends StatelessWidget {
  const EnquiryCard({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: ThemeColors.cardColor,
          borderRadius: BorderRadius.circular(50.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: ThemeColors.cardBorderColor,
            width: 0.3,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleSmallTitleBrown,
          ),
        ),
      ),
    );
  }
}
