import 'package:flutter/material.dart';

import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';

class DropDownRow extends StatelessWidget {
  final String label;
  final String value;
  final List<String> options;
  final bool? isDropdown;
  final ValueChanged<String?> onChanged;

  const DropDownRow({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    this.isDropdown = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMediumTitleBrown,
        ),
        isDropdown == true
            ? Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                  color: ThemeColors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Center(
                  child: DropdownButton<String>(
                    value: value,
                    elevation: 16,
                    alignment: Alignment.center,
                    underline: Container(
                      height: 2,
                      color: Colors.transparent,
                    ),
                    onChanged: onChanged,
                    items: options.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMediumPrimary
                                .copyWith(
                                  fontFamily: ThemeFonts.poppins,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              )
            : Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                  color: ThemeColors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    value,
                    style:
                        Theme.of(context).textTheme.bodyMediumPrimary.copyWith(
                              fontFamily: ThemeFonts.poppins,
                              fontWeight: FontWeight.w500,
                            ),
                  ),
                ),
              ),
      ],
    );
  }
}
