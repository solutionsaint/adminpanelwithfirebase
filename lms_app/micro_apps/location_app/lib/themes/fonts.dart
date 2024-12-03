import 'package:flutter/material.dart';

import 'package:location_app/themes/colors.dart';

class ThemeFonts {
  ThemeFonts._();

  static const String poppins = 'Poppins';
  static final ThemeData baseTheme = ThemeData.light();
  static final TextTheme textTheme = baseTheme.textTheme;

  static TextTheme buildLightTextTheme(BuildContext context) {
    return baseTheme.textTheme
        .copyWith(
          headlineLarge: baseTheme.textTheme.headlineLarge!.copyWith(
            fontSize: 32,
            fontWeight: FontWeight.w600,
            color: ThemeColors.authPrimary,
          ),
          headlineMedium: baseTheme.textTheme.headlineMedium!.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: ThemeColors.authPrimary,
          ),
          headlineSmall: baseTheme.textTheme.headlineSmall!.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: ThemeColors.authPrimary,
          ),
          titleLarge: baseTheme.textTheme.titleLarge!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: ThemeColors.white,
          ),
          titleSmall: baseTheme.textTheme.titleSmall!.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: ThemeColors.primary,
          ),
          bodyLarge: baseTheme.textTheme.bodyLarge!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: ThemeColors.brown,
          ),
          bodyMedium: baseTheme.textTheme.bodyMedium!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: ThemeColors.white,
          ),
          bodySmall: baseTheme.textTheme.bodySmall!.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: ThemeColors.titleBrown,
          ),
          displayMedium: baseTheme.textTheme.displayMedium!.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: ThemeColors.brown,
          ),
          displaySmall: baseTheme.textTheme.displaySmall!.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: ThemeColors.titleBrown,
          ),
        )
        .apply(
          fontFamily: poppins,
        );
  }
}

extension ThemeExtension on TextTheme {
  TextStyle get titleSmallTitleBrown =>
      titleSmall!.copyWith(color: ThemeColors.titleBrown);
  TextStyle get titleSmallWhite =>
      titleSmall!.copyWith(color: ThemeColors.white);
  TextStyle get displayMediumPrimary =>
      displayMedium!.copyWith(color: ThemeColors.authPrimary);
  TextStyle get displayMediumBlack =>
      displayMedium!.copyWith(color: ThemeColors.black);
  TextStyle get displayMediumSemiBold => displayMedium!
      .copyWith(color: ThemeColors.brown, fontWeight: FontWeight.w500);
  TextStyle get displayMediumSemiBoldWhite => displayMedium!
      .copyWith(color: ThemeColors.white, fontWeight: FontWeight.w500);
  TextStyle get displayMediumTitleBrownSemiBold => displayMedium!
      .copyWith(color: ThemeColors.titleBrown, fontWeight: FontWeight.w500);
  TextStyle get displayMediumBrownSemiBold => displayMedium!
      .copyWith(color: ThemeColors.brown, fontWeight: FontWeight.w500);
  TextStyle get displayMediumPrimarySemiBold => displayMedium!
      .copyWith(color: ThemeColors.primary, fontWeight: FontWeight.w500);
  TextStyle get displayMediumBold => displayMedium!
      .copyWith(color: ThemeColors.authPrimary, fontWeight: FontWeight.w600);
  TextStyle get displayMediumBoldBrown => displayMedium!
      .copyWith(color: ThemeColors.brown, fontWeight: FontWeight.w600);
  TextStyle get bodyMediumPrimary =>
      bodyMedium!.copyWith(color: ThemeColors.primary);
  TextStyle get bodyMediumTitleBrown =>
      bodyMedium!.copyWith(color: ThemeColors.titleBrown);
  TextStyle get bodyMediumTitleBrownSemiBold => bodyMedium!
      .copyWith(color: ThemeColors.titleBrown, fontWeight: FontWeight.w500);
  TextStyle get bodyLargeTitleBrown =>
      bodyLarge!.copyWith(color: ThemeColors.titleBrown);
  TextStyle get bodyLargeTitleBrownBold => bodyLarge!
      .copyWith(color: ThemeColors.titleBrown, fontWeight: FontWeight.w600);
  TextStyle get titleLargePrimary =>
      titleLarge!.copyWith(color: ThemeColors.titleBrown);
  TextStyle get displaySmallTitleBrownSemiBold => displaySmall!
      .copyWith(color: ThemeColors.primary, fontWeight: FontWeight.w500);
  TextStyle get displaySmallPrimarySemiBold => displaySmall!
      .copyWith(color: ThemeColors.primary, fontWeight: FontWeight.w500);
}
