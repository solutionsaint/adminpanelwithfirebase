import 'package:flutter/material.dart';
import 'package:location_app/screens/student_teacher/access_code_screen.dart';

import 'package:location_app/screens/student_teacher/student_teacher_location_screen.dart';
import 'package:location_app/screens/student_teacher/student_teacher_location_updated.dart';

class StudentTeacherRoutes {
  const StudentTeacherRoutes._();

  static const String location = '/location';
  static const String accessCode = '/access-code';
  static const String locationUpdated = '/location-updated';

  static Map<String, WidgetBuilder> get buildStudentTeacherRoutes {
    return {
      accessCode: (context) => const AccessCodeScreen(),
      location: (context) => const StudentTeacherLocationScreen(),
      locationUpdated: (context) => const StudentTeacherLocationUpdatedScreen(),
    };
  }

  static String get initialStudentRoute {
    return StudentTeacherRoutes.accessCode;
  }
}
