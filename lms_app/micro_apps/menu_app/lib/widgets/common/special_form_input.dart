import 'package:menu_app/themes/fonts.dart';
import 'package:flutter/material.dart';

import 'package:menu_app/themes/colors.dart';

class SpecialFormInput extends StatefulWidget {
  const SpecialFormInput({
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
    this.onFocusChange,
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
  final void Function(bool)? onFocusChange;

  @override
  State<SpecialFormInput> createState() => _SpecialFormInputState();
}

class _SpecialFormInputState extends State<SpecialFormInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
  }

  @override
  void didUpdateWidget(SpecialFormInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text && widget.text != _controller.text) {
      _controller.text = widget.text;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.isDescription ? 200 : null,
      decoration: widget.hasShadow
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
      child: Focus(
        onFocusChange: widget.onFocusChange,
        child: TextFormField(
          focusNode: widget.focusNode,
          autofillHints: widget.autofillHints,
          expands: widget.isDescription ? true : false,
          minLines: widget.isDescription ? null : 1,
          maxLines: widget.isDescription ? null : 1,
          textAlignVertical: TextAlignVertical.top,
          keyboardType: widget.keyboardType,
          initialValue: widget.initialValue,
          obscureText: widget.obscureText ?? false,
          onTap: widget.onTap,
          onSaved: widget.onSaved,
          onChanged: widget.onChanged,
          style: Theme.of(context).textTheme.titleSmallTitleBrown,
          decoration: InputDecoration(
            fillColor: widget.fillColor,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(
                color: widget.borderColor ?? ThemeColors.authPrimary,
                width: widget.borderWidth ?? 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide(
                color: widget.borderColor ?? ThemeColors.primary,
                width: widget.borderWidth ?? 2,
              ),
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: widget.suffixIcon,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelStyle: Theme.of(context).textTheme.displaySmall,
            hintText: widget.text,
            hintStyle: widget.hintTextStyle,
            errorStyle: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: ThemeColors.primary),
          ),
          validator: widget.validator,
          controller: widget.controller ?? _controller,
          readOnly: widget.readOnly ?? false,
          enabled: widget.enabled ?? true,
        ),
      ),
    );
  }
}
