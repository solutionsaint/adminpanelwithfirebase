import 'package:flutter/material.dart';

import 'package:menu_app/models/courses/course_model.dart';
import 'package:menu_app/routes/student_teacher_routes.dart';
import 'package:menu_app/themes/fonts.dart';
import 'package:menu_app/widgets/common/course_card.dart';

class MyCoursesWidget extends StatelessWidget {
  const MyCoursesWidget({
    super.key,
    required this.courses,
    required this.isLoading,
    required this.subCategory,
  });

  final List<CourseModel> courses;
  final bool isLoading;
  final String subCategory;

  void navigateToCourseDetail(BuildContext context, CourseModel course) {
    Navigator.of(context).pushNamed(
      StudentTeacherRoutes.courseDetail,
      arguments: {
        'course': course,
        'subCategory': subCategory,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (courses.isEmpty) {
      return Center(
        child: Text(
          'Nothing found',
          style: Theme.of(context).textTheme.bodyMediumPrimary,
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          return CourseCard(
            subCategory: subCategory,
            course: courses[index],
            onPressed: () => navigateToCourseDetail(context, courses[index]),
          );
        },
      ),
    );
  }
}
