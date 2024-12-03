import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/routes/admin_routes.dart';
import 'package:attendance_app/themes/colors.dart';
import 'package:attendance_app/themes/fonts.dart';
import 'package:attendance_app/widgets/common/icon_text_button.dart';
import 'package:attendance_app/resources/icons.dart' as icons;
import 'package:flutter/material.dart';

import 'package:attendance_app/widgets/common/course_card.dart';

class ItemListWidget extends StatelessWidget {
  const ItemListWidget({
    super.key,
    required this.myCourses,
  });

  final List<CourseModel> myCourses;

  void navigateToAttendance(BuildContext context, CourseModel course) {
    Navigator.of(context).pushNamed(
      AdminRoutes.itemDetail,
      arguments: course,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (myCourses.isEmpty) {
      return Center(
        child: Text(
          "Add Some Courses",
          style: Theme.of(context).textTheme.bodyMediumPrimary,
        ),
      );
    }
    final Size screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
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
                  onTap: () => navigateToAttendance(context, course),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: screenSize.width * 0.7,
          height: 50,
          child: IconTextButton(
            iconHorizontalPadding: 5,
            radius: 20,
            text: Strings.attendanceEnquiry,
            onPressed: () {
              Navigator.of(context).pushNamed(AdminRoutes.receptionEnquiry);
            },
            color: ThemeColors.primary,
            buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
            svgIcon: icons.Icons.enquiry,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
