import 'package:flutter/material.dart';

import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';

class AddItemCard extends StatelessWidget {
  const AddItemCard({super.key, required this.onTap});

  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: ThemeColors.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: ThemeColors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: ThemeColors.cardBorderColor,
            width: 0.3,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Add Item",
                style: Theme.of(context).textTheme.bodyLargeTitleBrownBold,
              ),
              Icon(
                Icons.add,
                size: 25,
                color: ThemeColors.titleBrown,
              )
            ],
          ),
        ),
      ),
    );
  }
}
