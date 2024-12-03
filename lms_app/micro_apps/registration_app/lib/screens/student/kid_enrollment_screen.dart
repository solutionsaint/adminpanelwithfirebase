import 'package:flutter/material.dart';
import 'package:registration_app/containers/student/kid_enrollment_container.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/routes/student_routes.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';

class KidEnrollmentScreen extends StatelessWidget {
  const KidEnrollmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final registrationIds = args['registrationIds'];
    final courses = args['courses'];
    final uid = args['uid'];

    return ScreenLayout(
      topBarText: Strings.enrollmentInitiated,
      onBack: () {
        Navigator.of(context).pushNamed(StudentRoutes.itemList);
      },
      child: KidEnrollmentContainer(
        registrationIds: registrationIds,
        courses: courses,
        uid: uid,
      ),
    );
  }
}
