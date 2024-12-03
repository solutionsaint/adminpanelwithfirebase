import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:registration_app/models/registration/course_model.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/routes/student_routes.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/widgets/common/icon_text_button.dart';
import 'package:registration_app/widgets/student/cart_card.dart';
import 'package:registration_app/resources/icons.dart' as icons;

class CartWidget extends StatelessWidget {
  const CartWidget({
    super.key,
    required this.courses,
    required this.onRemoveFromCat,
  });

  final List<CourseModel> courses;
  final Function(String) onRemoveFromCat;

  int getOfferValue(String batchDay, String batchTime) {
    String day = batchDay.toLowerCase();
    String time = batchTime.toLowerCase();

    if (day == 'weekday' && time == 'morning') {
      return 20;
    } else if (day == 'weekday' && time == 'evening') {
      return 15;
    } else if (day == 'weekend' && time == 'morning') {
      return 10;
    } else if (day == 'weekend' && time == 'evening') {
      return 5;
    } else {
      return 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: screenWidth * 0.9,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: courses.length,
              itemBuilder: (context, index) {
                final course = courses[index];

                return CartCard(
                  onRemoveFromCart: () {
                    onRemoveFromCat(course.courseId);
                  },
                  imageUrl: course.imageUrl,
                  title: course.courseTitle,
                  amount: course.amount.toString(),
                  discount:
                      getOfferValue(course.batchDay, course.batchTime ?? ''),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: screenWidth * 0.7,
            height: 50,
            child: IconTextButton(
              iconHorizontalPadding: 7,
              radius: 20,
              text: Strings.proceedToCheckout,
              onPressed: () {
                Navigator.of(context).pushNamed(StudentRoutes.register);
              },
              color: ThemeColors.primary,
              buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
              svgIcon: icons.Icons.cartIconSvg,
            ),
          ),
          const SizedBox(height: 100),
        ],
      ),
    );
  }
}
