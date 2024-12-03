import 'package:flutter/material.dart';

import 'package:menu_app/models/courses/course_model.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.onPressed,
    required this.course,
    required this.subCategory,
  });

  final Function() onPressed;
  final CourseModel course;
  final String subCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: ThemeColors.cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SizedBox(
          height: 150.0,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16.0),
                      bottomLeft: Radius.circular(16.0),
                    ),
                    border: Border(
                      top: BorderSide(
                        color: ThemeColors.cardBorderColor,
                        width: 0.3,
                      ),
                      left: BorderSide(
                        color: ThemeColors.cardBorderColor,
                        width: 0.3,
                      ),
                      bottom: BorderSide(
                        color: ThemeColors.cardBorderColor,
                        width: 0.3,
                      ),
                    ),
                  ),
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.courseTitle,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMediumTitleBrownSemiBold
                            .copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 8.0),
                      if (subCategory == 'courses')
                        Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Day : ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMediumPrimary,
                                ),
                                SizedBox(
                                  width: 110,
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    course.batchDay,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displaySmall!
                                        .copyWith(fontSize: 12),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10.0),
                            Row(
                              children: [
                                Text(
                                  "Time : ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMediumPrimary,
                                ),
                                Text(
                                  course.batchTime!,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall!
                                      .copyWith(fontSize: 12),
                                ),
                              ],
                            ),
                          ],
                        ),
                      if (subCategory != 'courses')
                        Column(
                          children: [
                            Wrap(
                              children: [
                                Text(
                                  course.shortDescription,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMediumPrimary,
                                ),
                              ],
                            )
                          ],
                        ),
                      const SizedBox(height: 10.0),
                      Text(
                        'Rs.${course.amount.toString()}',
                        style: Theme.of(context)
                            .textTheme
                            .displaySmall!
                            .copyWith(fontSize: 16),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                  child: Image.network(
                    course.imageUrl,
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
