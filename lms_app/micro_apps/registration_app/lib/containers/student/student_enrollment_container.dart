import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/routes/student_routes.dart';

import 'package:registration_app/widgets/student/student_enrollment_widget.dart';

class StudentEnrollmentContainer extends StatefulWidget {
  const StudentEnrollmentContainer({
    super.key,
    required this.registrationIds,
    required this.courses,
  });

  final List<String> registrationIds;
  final List<CourseModel> courses;

  @override
  State<StudentEnrollmentContainer> createState() =>
      _StudentEnrollmentContainerState();
}

class _StudentEnrollmentContainerState
    extends State<StudentEnrollmentContainer> {
  void checkFaceRecognition() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (!authProvider.currentUser!.isFaceRecognized! &&
        !authProvider.currentUser!.isSomeone!) {
      Navigator.of(context)
          .pushNamed(StudentRoutes.faceRecognition, arguments: null);
    } else {
      Navigator.of(context).pushNamedAndRemoveUntil(
        StudentRoutes.itemList,
        (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return StudentEnrollmentWidget(
      registrationIds: widget.registrationIds,
      courses: widget.courses,
      onProceedToPayment: checkFaceRecognition,
    );
  }
}
