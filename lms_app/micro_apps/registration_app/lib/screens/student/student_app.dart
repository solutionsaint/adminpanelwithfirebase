import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/providers/auth_provider.dart';

import 'package:registration_app/routes/student_routes.dart';
import 'package:registration_app/themes/themes.dart';

class StudentApp extends StatelessWidget {
  const StudentApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final bool isInitialFace = authProvider.currentUser!.isSomeone! &&
        !authProvider.currentUser!.isFaceRecognized!;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.buildLightTheme(context),
      routes: StudentRoutes.buildStudentRoutes,
      initialRoute: isInitialFace
          ? StudentRoutes.someoneFaceRecognition
          : StudentRoutes.initialStudentRoute,
    );
  }
}
