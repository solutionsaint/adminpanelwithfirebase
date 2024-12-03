import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/providers/auth_provider.dart';

import 'package:registration_app/routes/routes.dart';
import 'package:registration_app/themes/themes.dart';

class RegistrationApp extends StatelessWidget {
  const RegistrationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (_) {
        return AuthProvider();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.buildLightTheme(context),
        routes: Routes.buildRoutes,
        initialRoute: Routes.initialRoute,
      ),
    );
  }
}
