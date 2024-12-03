import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/screens/auth/welcome_screen.dart';
import 'package:registration_app/utils/show_snackbar.dart';
import 'package:registration_app/widgets/student/kid_enrollment_widget.dart';

class KidEnrollmentContainer extends StatefulWidget {
  const KidEnrollmentContainer({
    super.key,
    required this.registrationIds,
    required this.courses,
    required this.uid,
  });

  final List<String> registrationIds;
  final List<CourseModel> courses;
  final String uid;

  @override
  State<KidEnrollmentContainer> createState() =>
      _StudentEnrollmentContainerState();
}

class _StudentEnrollmentContainerState extends State<KidEnrollmentContainer> {
  void logout() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final response = await authProvider.signOut();
    if (response) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      showSnackbar(context, Strings.errorLoggingOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return KidEnrollmentWidget(
      logout: logout,
      registrationIds: widget.registrationIds,
      courses: widget.courses,
    );
  }
}
