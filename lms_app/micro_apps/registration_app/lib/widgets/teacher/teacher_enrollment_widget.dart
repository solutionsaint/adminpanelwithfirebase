import 'package:flutter/material.dart';
import 'package:registration_app/models/registration/course_model.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/routes/teacher_routes.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';
import 'package:registration_app/widgets/common/form_input.dart';
import 'package:registration_app/widgets/common/icon_text_button.dart';
import 'package:registration_app/widgets/student/cart_card.dart';
import 'package:registration_app/resources/icons.dart' as icons;
import 'package:registration_app/widgets/teacher/status_progress_indicator.dart';

class TeacherEnrollmentWidget extends StatelessWidget {
  final CourseModel course;
  final String regId;

  const TeacherEnrollmentWidget({
    super.key,
    required this.course,
    required this.regId,
  });

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    void onPressed() {
      Navigator.of(context).pushNamedAndRemoveUntil(
        TeacherRoutes.itemList,
        (route) => false,
      );
    }

    return Column(
      children: [
        Container(
          height: 100,
          margin: const EdgeInsets.only(top: 10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: ThemeColors.cardBorderColor,
                width: 0.2,
              ),
              top: BorderSide(
                color: ThemeColors.cardBorderColor,
                width: 0.2,
              ),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 0,
                color: ThemeColors.black.withOpacity(0.1),
                offset: const Offset(0, 2),
              )
            ],
            color: ThemeColors.white,
          ),
          child: Row(
            children: [
              const SizedBox(width: 10),
              Text(
                Strings.registrationNo,
                style: Theme.of(context).textTheme.bodyMediumTitleBrown,
              ),
              Text(
                regId,
                style: Theme.of(context).textTheme.displayMediumPrimary,
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            width: screenSize.width * 0.9,
            child: ListView(
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              children: [
                CartCard(
                  imageUrl: course.imageUrl,
                  title: course.courseTitle,
                  description: course.shortDescription,
                  batchTime: course.batchTime,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      Strings.aboutDescription,
                      style: Theme.of(context).textTheme.bodyMediumPrimary,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  course.aboutDescription,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 20),
                Text(Strings.status,
                    style: Theme.of(context).textTheme.bodyMediumTitleBrown),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          width: 180,
                          child: FormInput(
                            text: "Status",
                            hintText: 'Pending',
                            initialValue: 'Pending',
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    StatusProgressIndicator(
                      isApproved: true,
                      isReady: false,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: screenSize.width * 0.7,
                    height: 50,
                    child: IconTextButton(
                      iconHorizontalPadding: 7,
                      radius: 20,
                      text: Strings.continueText,
                      onPressed: onPressed,
                      color: ThemeColors.primary,
                      buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
                      svgIcon: icons.Icons.cap,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
