import 'package:flutter/material.dart';

import 'package:menu_app/routes/student_teacher_routes.dart';
import 'package:menu_app/themes/themes.dart';

class StudentTeacherApp extends StatelessWidget {
  const StudentTeacherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.buildLightTheme(context),
      initialRoute: StudentTeacherRoutes.initialStudentTeacherRoute,
      routes: StudentTeacherRoutes.buildStudentTeacherRoutes,
    );
  }
}
