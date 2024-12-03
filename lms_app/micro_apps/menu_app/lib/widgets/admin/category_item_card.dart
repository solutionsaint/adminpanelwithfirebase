import 'package:flutter/material.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';

class CategoryItemCard extends StatelessWidget {
  const CategoryItemCard({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  final String icon; // URL for the network image
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: ThemeColors.cardColor,
          border: Border.all(
            color: ThemeColors.cardBorderColor,
            width: 0.3,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLargePrimary.copyWith(
                      fontSize: 20,
                    ),
              ),
              const SizedBox(
                width: 40,
              ),
              Image.network(
                icon,
                width: 30,
                height: 30,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
