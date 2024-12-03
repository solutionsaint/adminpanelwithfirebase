import 'package:attendance_app/routes/admin_routes.dart';
import 'package:attendance_app/themes/themes.dart';
import 'package:flutter/material.dart';

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.buildLightTheme(context),
      routes: AdminRoutes.buildAdminRoutes,
      initialRoute: AdminRoutes.initialRoute,
    );
  }
}
