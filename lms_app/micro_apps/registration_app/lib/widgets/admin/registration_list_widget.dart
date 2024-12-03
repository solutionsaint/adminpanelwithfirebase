import 'package:flutter/material.dart';

import 'package:registration_app/resources/images.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/routes/admin_routes.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';
import 'package:registration_app/widgets/common/icon_text_button.dart';
import 'package:registration_app/resources/icons.dart' as icons;

class RegistrationListWidget extends StatelessWidget {
  const RegistrationListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      width: screenSize.width * 0.9,
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        Strings.student,
                        style: Theme.of(context)
                            .textTheme
                            .titleLargePrimary
                            .copyWith(
                              fontSize: 20,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AdminRoutes.studentList);
                    },
                    child: const Image(
                      image: AssetImage(Images.studentCard),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        Strings.teacher,
                        style: Theme.of(context)
                            .textTheme
                            .titleLargePrimary
                            .copyWith(
                              fontSize: 20,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(AdminRoutes.teacherList);
                    },
                    child: const Image(
                      image: AssetImage(Images.teacherCard),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: screenSize.width * 0.7,
            height: 50,
            child: IconTextButton(
              iconHorizontalPadding: 5,
              radius: 20,
              text: Strings.registrationEnquiry,
              onPressed: () {
                Navigator.of(context).pushNamed(AdminRoutes.receptionEnquiry);
              },
              color: ThemeColors.primary,
              buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
              svgIcon: icons.Icons.enquiry,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
