import 'package:flutter/material.dart';

import 'package:attendance_app/routes/attendance_app_routes.dart';
import 'package:attendance_app/themes/themes.dart';

class StudentTeacherAttencanceApp extends StatelessWidget {
  const StudentTeacherAttencanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.buildLightTheme(context),
      routes: AttendanceAppRoutes.buildAttendanceAppRoutes,
      initialRoute: AttendanceAppRoutes.initialRoute,
    );
  }
}
