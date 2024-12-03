import 'package:flutter/material.dart';
import 'package:registration_app/models/registration/course_model.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';

class ItemDetailCard extends StatelessWidget {
  const ItemDetailCard({super.key, required this.course});

  final CourseModel course;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: ThemeColors.cardColor,
        border: Border.all(
          color: ThemeColors.cardBorderColor,
          width: 0.3,
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 5,
            spreadRadius: 0,
            color: ThemeColors.black.withOpacity(0.1),
          )
        ],
      ),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: Image.network(
                      course.imageUrl,
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.courseTitle,
                        style: Theme.of(context).textTheme.bodyLargeTitleBrown,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Text(
                            Strings.courseCode,
                            style: Theme.of(context)
                                .textTheme
                                .displayMediumTitleBrownSemiBold,
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: 70, // Adjust this value as needed
                            child: Text(
                              course.courseId,
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMediumPrimarySemiBold,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            Strings.duration,
                            style: Theme.of(context)
                                .textTheme
                                .displayMediumTitleBrownSemiBold,
                          ),
                          Text(
                            '${course.totalHours} Hours',
                            style: Theme.of(context)
                                .textTheme
                                .displayMediumPrimarySemiBold,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                course.shortDescription,
                style: Theme.of(context)
                    .textTheme
                    .displaySmall!
                    .copyWith(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
