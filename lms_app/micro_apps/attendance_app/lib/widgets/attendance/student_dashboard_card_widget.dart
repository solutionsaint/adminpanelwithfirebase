import 'package:flutter/material.dart';

import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/routes/attendance_app_routes.dart';
import 'package:attendance_app/themes/colors.dart';
import 'package:attendance_app/themes/fonts.dart';
import 'package:attendance_app/widgets/common/icon_text_button.dart';

class StudentDashboardCardWidget extends StatelessWidget {
  const StudentDashboardCardWidget({
    super.key,
    required this.name,
    required this.studentId,
    required this.attendedHours,
    required this.course,
  });

  final String name;
  final String studentId;
  final int attendedHours;
  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: ThemeColors.cardColor,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: ThemeColors.cardBorderColor,
          width: 0.3,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name",
                    style: Theme.of(context).textTheme.displayMediumPrimary,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: 110,
                    child: Text(
                      name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .displayMediumTitleBrownSemiBold,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Total Hours",
                    style: Theme.of(context).textTheme.displayMediumPrimary,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    course.totalHours.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .displayMediumTitleBrownSemiBold,
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Hours Spent",
                    style: Theme.of(context).textTheme.displayMediumPrimary,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    attendedHours.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .displayMediumTitleBrownSemiBold,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 100,
                child: IconTextButton(
                    text: "More Details",
                    buttonTextStyle:
                        Theme.of(context).textTheme.displayMedium!.copyWith(
                              color: ThemeColors.white,
                            ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          AttendanceAppRoutes.studentDetailViewStudent,
                          arguments: {
                            "course": course,
                            "attendedHours": attendedHours,
                            "studentName": name,
                            "studentId": studentId,
                          });
                    },
                    color: ThemeColors.primary,
                    iconHorizontalPadding: 0),
              ),
              const SizedBox(width: 20),
            ],
          )
        ],
      ),
    );
  }
}
