import 'package:enquiry_app/screens/auth/init_screen.dart';
import 'package:flutter/material.dart';

import 'package:enquiry_app/screens/auth/options_screen.dart';
import 'package:enquiry_app/screens/auth/welcome_screen.dart';

class Routes {
  const Routes._();

  static const String initScreen = '/';
  static const String optionsScreen = '/options';
  static const String welcomeScreen = '/welcome';

  static Map<String, WidgetBuilder> get buildRoutes {
    return {
      initScreen: (ctx) => const InitScreen(),
      optionsScreen: (ctx) => const OptionsScreen(),
      welcomeScreen: (ctx) => const WelcomeScreen(),
    };
  }

  static String get initialRoute {
    return Routes.initScreen;
  }

  static Widget get initialScreen {
    return const InitScreen();
  }
}
