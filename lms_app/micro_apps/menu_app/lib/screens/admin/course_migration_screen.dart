import 'package:flutter/material.dart';
import 'package:menu_app/containers/admin/course_migration_container.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/widgets/menu/menu_layout.dart';

class CourseMigrationScreen extends StatelessWidget {
  const CourseMigrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    List<String> newCourses = data['newCourses'] as List<String>;
    String oldCourseId = data['oldCourse'] as String;
    return MenuLayout(
      topBarText: Strings.courseMigration,
      child: CourseMigrationContainer(
        courseIds: newCourses,
        oldCourseId: oldCourseId,
      ),
    );
  }
}
