import 'package:flutter/material.dart';

import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';

class Themes {
  Themes._();

  static AppBarTheme _buildAppBarTheme() {
    return const AppBarTheme(elevation: 0);
  }

  static ThemeData buildLightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      splashFactory: NoSplash.splashFactory,
      appBarTheme: _buildAppBarTheme(),
      fontFamily: ThemeFonts.poppins,
      textTheme: ThemeFonts.buildLightTextTheme(context),
      scaffoldBackgroundColor: ThemeColors.white,
      primaryColor: ThemeColors.primary,
      colorScheme: ColorScheme.light(
        primary: ThemeColors.primary,
        secondary: ThemeColors.primary,
      ),
    );
  }
}
