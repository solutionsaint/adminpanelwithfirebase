import 'package:flutter/material.dart';

import 'package:menu_app/screens/auth/options_screen.dart';
import 'package:menu_app/screens/auth/init_screen.dart';
import 'package:menu_app/screens/common/welcome_screen.dart';

class Routes {
  const Routes._();

  static const String initScreen = '/';
  static const String optionsScreen = '/options';
  static const String welcomeScreen = '/welcome';

  static Map<String, WidgetBuilder> get buildRoutes {
    return {
      initScreen: (ctx) => const InitScreen(),
      welcomeScreen: (ctx) => const WelcomeScreen(),
      optionsScreen: (ctx) => const OptionsScreen()
    };
  }

  static String get initialRoute {
    return Routes.initScreen;
  }

  static Widget get initialScreen {
    return const InitScreen();
  }
}