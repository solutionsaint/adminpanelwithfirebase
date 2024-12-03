import 'package:flutter/material.dart';

import 'package:menu_app/routes/admin_routes.dart';
import 'package:menu_app/themes/themes.dart';

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.buildLightTheme(context),
      initialRoute: AdminRoutes.initialAdminRoute,
      routes: AdminRoutes.buildAdminRoutes,
    );
  }
}
