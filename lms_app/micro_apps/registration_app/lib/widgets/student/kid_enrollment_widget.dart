import 'package:flutter/material.dart';
import 'package:registration_app/models/registration/course_model.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';
import 'package:registration_app/widgets/common/icon_text_button.dart';
import 'package:registration_app/widgets/student/cart_card.dart';
import 'package:registration_app/resources/icons.dart' as icons;

class KidEnrollmentWidget extends StatelessWidget {
  const KidEnrollmentWidget({
    super.key,
    required this.registrationIds,
    required this.courses,
    required this.logout,
  });

  final List<String> registrationIds;
  final List<CourseModel> courses;
  final void Function()? logout;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

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
                registrationIds[0],
                style: Theme.of(context).textTheme.displayMediumPrimary,
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            width: screenSize.width * 0.9,
            child: ListView(
              shrinkWrap: true,
              children: [
                ...courses.map(
                  (course) => CartCard(
                    imageUrl: course.imageUrl,
                    title: course.courseTitle,
                    amount: course.amount.toString(),
                    description: course.aboutDescription,
                    discount: 10,
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  children: [
                    Text(
                      Strings.anEmailVerificationLinkSent,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMediumTitleBrownSemiBold,
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
                      text: Strings.logout,
                      onPressed: logout,
                      color: ThemeColors.primary,
                      buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
                      svgIcon: icons.Icons.cartIconSvg,
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
