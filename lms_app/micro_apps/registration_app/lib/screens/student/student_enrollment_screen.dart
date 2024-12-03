import 'package:flutter/material.dart';

import 'package:registration_app/containers/student/student_enrollment_container.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/routes/student_routes.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';

class StudentEnrollmentScreen extends StatelessWidget {
  const StudentEnrollmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final registrationIds = args['registrationIds'];
    final courses = args['courses'];

    return ScreenLayout(
      topBarText: Strings.enrollmentInitiated,
      onBack: () {
        print(".......");
        Navigator.of(context).pushNamed(StudentRoutes.itemList);
      },
      child: StudentEnrollmentContainer(
        registrationIds: registrationIds,
        courses: courses,
      ),
    );
  }
}
