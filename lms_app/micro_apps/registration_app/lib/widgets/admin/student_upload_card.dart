import 'dart:io';

import 'package:flutter/material.dart';

import 'package:registration_app/models/registration/student_registration_model.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';
import 'package:registration_app/widgets/admin/action_button.dart';
import 'package:registration_app/resources/icons.dart' as icons;

class StudentUploadCard extends StatelessWidget {
  const StudentUploadCard({
    super.key,
    required this.student,
    required this.pickImage,
    this.feeReceiptImage,
    this.applicationReceiptImage,
  });

  final StudentRegistrationModel student;
  final void Function(bool) pickImage;
  final File? feeReceiptImage;
  final File? applicationReceiptImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: ThemeColors.white,
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
      padding: const EdgeInsets.symmetric(
        vertical: 30,
        horizontal: 20,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${Strings.name} : ',
                        style: Theme.of(context)
                            .textTheme
                            .displayMediumTitleBrownSemiBold,
                      ),
                      Text(
                        student.userName,
                        style: Theme.of(context)
                            .textTheme
                            .displayMediumPrimarySemiBold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        '${Strings.course1} : ',
                        style: Theme.of(context)
                            .textTheme
                            .displayMediumTitleBrownSemiBold,
                      ),
                      Text(
                        student.courseName,
                        style: Theme.of(context)
                            .textTheme
                            .displayMediumPrimarySemiBold,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        '${Strings.payment} : ',
                        style: Theme.of(context)
                            .textTheme
                            .displayMediumTitleBrownSemiBold,
                      ),
                      Text(
                        student.paymentStatus == 'done'
                            ? Strings.done
                            : Strings.pending,
                        style: Theme.of(context)
                            .textTheme
                            .displayMediumPrimarySemiBold
                            .copyWith(
                              color: student.paymentStatus == 'done'
                                  ? ThemeColors.primary
                                  : ThemeColors.titleBrown,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(50.0),
                child: Image.network(
                  student.imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(children: [
            Text(
              Strings.update,
              style: Theme.of(context).textTheme.bodyMediumPrimary,
            )
          ]),
          const SizedBox(height: 30),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ActionButton(
                text: Strings.feeReceipt,
                icon: feeReceiptImage == null
                    ? icons.Icons.upload
                    : icons.Icons.accept,
                onTap: () => pickImage(true),
                width: 200,
                height: 40,
              ),
              const SizedBox(height: 30),
              ActionButton(
                text: Strings.applicationReceipt,
                icon: applicationReceiptImage == null
                    ? icons.Icons.upload
                    : icons.Icons.accept,
                onTap: () => pickImage(false),
                width: 200,
                height: 40,
              ),
            ],
          )
        ],
      ),
    );
  }
}
