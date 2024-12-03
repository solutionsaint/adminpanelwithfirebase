import 'package:flutter/material.dart';

import 'package:registration_app/screens/auth/init_screen.dart';
import 'package:registration_app/screens/auth/options_screen.dart';
import 'package:registration_app/screens/auth/role_type_selection_screen.dart';
import 'package:registration_app/screens/auth/welcome_screen.dart';

class Routes {
  const Routes._();

  static const String initScreen = '/';
  static const String optionsScreen = '/options';
  static const String welcomeScreen = '/welcome';
  static const String roleTypeSelectionScreen = '/role-type-selection';

  static Map<String, WidgetBuilder> get buildRoutes {
    return {
      initScreen: (ctx) => const InitScreen(),
      welcomeScreen: (ctx) => const WelcomeScreen(),
      optionsScreen: (ctx) => const OptionsScreen(),
      roleTypeSelectionScreen: (ctx) => const RoleTypeSelectionScreen(),
    };
  }

  static String get initialRoute {
    return Routes.initScreen;
  }

  static Widget get initialScreen {
    return const InitScreen();
  }
}
