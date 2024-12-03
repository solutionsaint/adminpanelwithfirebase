import 'package:flutter/material.dart';

import 'package:enquiry_app/routes/student_teacher_routes.dart';
import 'package:enquiry_app/resources/icons.dart' as icons;
import 'package:enquiry_app/resources/strings.dart';
import 'package:enquiry_app/themes/colors.dart';
import 'package:enquiry_app/widgets/common/enquiry_card.dart';
import 'package:enquiry_app/widgets/common/icon_text_button.dart';

class EnquiryArguments {
  final String title;

  EnquiryArguments(this.title);
}

class RaiseEnquiryWidget extends StatelessWidget {
  const RaiseEnquiryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.only(top: 5),
      width: screenSize.width * 0.9,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  EnquiryCard(
                    text: Strings.reception,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        StudentTeacherRoutes.enquiryReception,
                        arguments: EnquiryArguments(Strings.reception),
                      );
                    },
                  ),
                  EnquiryCard(
                    text: Strings.registration,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        StudentTeacherRoutes.enquiryReception,
                        arguments: EnquiryArguments(Strings.registration),
                      );
                    },
                  ),
                  EnquiryCard(
                    text: Strings.attendance,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        StudentTeacherRoutes.enquiryReception,
                        arguments: EnquiryArguments(Strings.attendance),
                      );
                    },
                  ),
                  EnquiryCard(
                    text: Strings.location,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        StudentTeacherRoutes.enquiryReception,
                        arguments: EnquiryArguments(Strings.location),
                      );
                    },
                  ),
                  EnquiryCard(
                    text: Strings.owner,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        StudentTeacherRoutes.enquiryReception,
                        arguments: EnquiryArguments(Strings.owner),
                      );
                    },
                  ),
                  EnquiryCard(
                    text: Strings.custom,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        StudentTeacherRoutes.enquiryReception,
                        arguments: EnquiryArguments(Strings.custom),
                      );
                    },
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
              iconHorizontalPadding: 7,
              radius: 20,
              text: Strings.myTickets,
              onPressed: () {
                Navigator.of(context).pushNamed(StudentTeacherRoutes.myTickets);
              },
              color: ThemeColors.primary,
              buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
              svgIcon: icons.Icons.ticket,
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
