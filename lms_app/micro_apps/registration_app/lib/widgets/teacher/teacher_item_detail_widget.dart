import 'package:flutter/material.dart';
import 'package:registration_app/models/registration/course_model.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/routes/teacher_routes.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';
import 'package:registration_app/utils/show_snackbar.dart';
import 'package:registration_app/widgets/common/batch_card.dart';
import 'package:registration_app/widgets/common/icon_text_button.dart';
import 'package:registration_app/resources/icons.dart' as icons;
import 'package:registration_app/widgets/common/item_detail_card.dart';

class TeacherItemDetailWidget extends StatefulWidget {
  const TeacherItemDetailWidget({super.key, required this.course});

  final CourseModel course;

  @override
  State<TeacherItemDetailWidget> createState() =>
      _TeacherItemDetailWidgetState();
}

class _TeacherItemDetailWidgetState extends State<TeacherItemDetailWidget> {
  String selectedBatchDay = 'Weekend';
  String selectedBatchTime = 'Morning';

  void onPressed(BuildContext context) {
    if (selectedBatchDay == '' || selectedBatchTime == '') {
      showSnackbar(context, 'Please select a batch day and time');
      return;
    }

    Navigator.of(context).pushNamed(
      TeacherRoutes.register,
      arguments: {
        'course': widget.course,
        'batchDay': selectedBatchDay,
        'batchTime': selectedBatchTime,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        width: screenWidth * 0.9,
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ItemDetailCard(course: widget.course),
            const SizedBox(height: 20),
            Text(
              Strings.aboutDescription,
              style: Theme.of(context)
                  .textTheme
                  .bodyMediumPrimary
                  .copyWith(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Text(
              widget.course.aboutDescription,
              style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  Strings.batchOffered,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMediumPrimary
                      .copyWith(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Days",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMediumPrimary
                          .copyWith(fontSize: 20),
                    ),
                  ],
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      ...widget.course.batchDay.split('+').map(
                            (day) => Container(
                              margin: const EdgeInsets.only(bottom: 7),
                              child: Text(
                                day,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(fontSize: 16),
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
            if (widget.course.batchTime != null &&
                widget.course.batchTime!.isNotEmpty)
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        "Timing : ",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMediumPrimary
                            .copyWith(fontSize: 20),
                      ),
                      Text(
                        widget.course.batchTime!,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall!
                            .copyWith(fontSize: 16),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: screenWidth * 0.7,
                  height: 50,
                  child: IconTextButton(
                    iconHorizontalPadding: 7,
                    radius: 20,
                    text: Strings.proceed,
                    onPressed: () => onPressed(context),
                    color: ThemeColors.primary,
                    buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
                    svgIcon: icons.Icons.cartIconSvg,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
