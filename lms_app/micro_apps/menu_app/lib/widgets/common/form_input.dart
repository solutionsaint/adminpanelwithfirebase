import 'package:menu_app/themes/fonts.dart';
import 'package:flutter/material.dart';

import 'package:menu_app/themes/colors.dart';

class FormInput extends StatelessWidget {
  const FormInput({
    super.key,
    required this.text,
    this.obscureText = false,
    this.readOnly,
    this.focusNode,
    this.keyboardType,
    this.onSaved,
    this.borderColor,
    this.validator,
    this.controller,
    this.onChanged,
    this.onTap,
    this.prefixIcon,
    this.suffixIcon,
    this.hintTextStyle,
    this.initialValue,
    this.hintText,
    this.enabled,
    this.fillColor,
    this.borderWidth,
    this.hasShadow = false,
    this.isDescription = false,
    this.autofillHints,
    this.helperText,
  });

  final String text;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final bool? readOnly;
  final FocusNode? focusNode;
  final TextStyle? hintTextStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? borderColor;
  final void Function()? onTap;
  final String? initialValue;
  final String? hintText;
  final bool? enabled;
  final Color? fillColor;
  final double? borderWidth;
  final bool hasShadow;
  final bool isDescription;
  final Iterable<String>? autofillHints;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isDescription ? 200 : null,
      decoration: hasShadow
          ? BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: ThemeColors.black.withOpacity(0.1),
                  blurRadius: 9,
                  offset: const Offset(1, 2.5),
                  spreadRadius: 0,
                ),
              ],
              borderRadius: BorderRadius.circular(50.0),
            )
          : null, // No shadow if hasShadow is false
      child: TextFormField(
        focusNode: focusNode,
        autofillHints: autofillHints,
        expands: isDescription ? true : false,
        minLines: isDescription ? null : 1,
        maxLines: isDescription ? null : 1,
        textAlignVertical: TextAlignVertical.top,
        keyboardType: keyboardType,
        initialValue: initialValue,
        obscureText: obscureText ?? false,
        onTap: onTap,
        onSaved: onSaved,
        onChanged: onChanged,
        style: Theme.of(context).textTheme.titleSmallTitleBrown,
        decoration: InputDecoration(
          fillColor: fillColor,
          filled: true,
          helperText: helperText,
          helperStyle: TextStyle(
            color: ThemeColors.primary,
            fontSize: 12,
          ),
          helperMaxLines: 3,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(
              color: borderColor ?? ThemeColors.authPrimary,
              width: borderWidth ?? 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(
              color: borderColor ?? ThemeColors.primary,
              width: borderWidth ?? 2,
            ),
          ),
          prefixIcon: prefixIcon,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: suffixIcon,
          ),
          label: text.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text,
                    style: Theme.of(context)
                        .textTheme
                        .displaySmall!
                        .copyWith(fontSize: 14.0),
                  ),
                )
              : null, // Conditionally display the label if text is not null
          labelStyle: Theme.of(context).textTheme.displaySmall,
          hintText: hintText,
          hintStyle: hintTextStyle,
          errorStyle: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: ThemeColors.primary),
        ),
        validator: validator,
        controller: controller,
        readOnly: readOnly ?? false,
        enabled: enabled ?? true,
      ),
    );
  }
}
