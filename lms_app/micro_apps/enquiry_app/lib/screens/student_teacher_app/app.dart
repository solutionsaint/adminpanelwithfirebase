import 'package:flutter/material.dart';

import 'package:enquiry_app/routes/student_teacher_routes.dart';
import 'package:enquiry_app/themes/themes.dart';

class StudentTeacherApp extends StatelessWidget {
  const StudentTeacherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.buildLightTheme(context),
      routes: StudentTeacherRoutes.buildStudentTeacherRoutes,
      initialRoute: StudentTeacherRoutes.initialRoute,
    );
  }
}
