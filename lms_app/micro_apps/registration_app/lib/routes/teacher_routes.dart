import 'package:flutter/material.dart';

import 'package:registration_app/screens/teacher/teacher_access_code_screen.dart';
import 'package:registration_app/screens/teacher/teacher_enrollment_screen.dart';
import 'package:registration_app/screens/teacher/teacher_item_detail_screen.dart';
import 'package:registration_app/screens/teacher/teacher_item_list_screen.dart';
import 'package:registration_app/screens/teacher/teacher_register_screen.dart';

class TeacherRoutes {
  const TeacherRoutes._();

  static const String itemList = '/';
  static const String accessCode = 'access-code';
  static const String itemDetail = '/item-detail';
  static const String register = '/register';
  static const String enrollment = '/enrollment';

  static Map<String, WidgetBuilder> get buildTeacherRoutes {
    return {
      accessCode: (context) => const TeacherAccessCodeScreen(),
      itemList: (context) => const TeacherItemListScreen(),
      itemDetail: (context) => const TeacherItemDetailScreen(),
      register: (context) => const TeacherRegisterScreen(),
      enrollment: (context) => const TeacherEnrollmentScreen(),
    };
  }

  static String get initialTeacherRoute {
    return TeacherRoutes.accessCode;
  }
}
