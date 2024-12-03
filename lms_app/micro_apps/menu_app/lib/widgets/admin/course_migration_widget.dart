import 'package:flutter/material.dart';

import 'package:menu_app/models/courses/course_model.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/themes/fonts.dart';
import 'package:menu_app/widgets/common/course_card.dart';

class CourseMigrationWidget extends StatelessWidget {
  const CourseMigrationWidget({
    super.key,
    required this.myCourses,
    required this.migrateCourse,
  });

  final List<CourseModel> myCourses;
  final void Function(String courseId) migrateCourse;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        const SizedBox(height: 20),
        Text(
          Strings.selectAnCourse,
          style: Theme.of(context).textTheme.bodyLargeTitleBrownBold,
        ),
        Expanded(
          child: Container(
            width: screenSize.width * 0.9,
            margin: const EdgeInsets.only(top: 5),
            child: ListView.builder(
              padding: const EdgeInsets.all(0),
              itemCount: myCourses.length,
              itemBuilder: (ctx, index) {
                final course = myCourses[index];
                return CourseCard(
                  course: course,
                  onPressed: () {
                    migrateCourse(course.courseId);
                  },
                  subCategory: 'courses',
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
