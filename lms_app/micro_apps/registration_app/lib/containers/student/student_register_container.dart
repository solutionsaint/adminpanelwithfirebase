import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/core/services/registration/registration_service.dart';
import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/routes/student_routes.dart';
import 'package:registration_app/utils/show_snackbar.dart';

import 'package:registration_app/widgets/student/student_register_widget.dart';

class StudentRegisterContainer extends StatefulWidget {
  const StudentRegisterContainer({super.key});

  @override
  State<StudentRegisterContainer> createState() =>
      _StudentRegisterContainerState();
}

class _StudentRegisterContainerState extends State<StudentRegisterContainer> {
  bool isLoading = false;

  Future<void> registerStudent(
    String selectedOption,
    String batchDay,
    String batchTime,
  ) async {
    final registrationService = RegistrationService();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final courseIds = authProvider.cart.map((e) => e.courseId).toList();
    if (selectedOption == 'Self') {
      setState(() {
        isLoading = true;
      });
      final response = await registrationService.registerStudent(
        courses: authProvider.cart,
        registeredBy: authProvider.currentUser!.uid,
        email: authProvider.currentUser!.email,
        userName: authProvider.currentUser!.name,
        mobileNumber: authProvider.currentUser!.phone,
        registeredFor: selectedOption,
        instituteId: authProvider.selectedinstituteCode,
      );
      if (response.isNotEmpty) {
        authProvider.updateRegisteredCoursesList(courseIds);
        final List<CourseModel> courseData = authProvider.cart;
        authProvider.cart = [];
        showSnackbar(context, 'Course registered successfully');
        Navigator.of(context)
            .pushReplacementNamed(StudentRoutes.enrollment, arguments: {
          'registrationIds': response,
          'courses': courseData,
        });
      } else {
        showSnackbar(context, 'Failed to register course');
      }

      setState(() {
        isLoading = false;
      });
    } else if (selectedOption == 'For Someone else') {
      Navigator.of(context)
          .pushNamed(StudentRoutes.kidRegistration, arguments: {
        'courses': authProvider.cart,
        'batchDay': batchDay,
        'batchTime': batchTime,
        'email': authProvider.currentUser!.email,
        'userName': authProvider.currentUser!.name,
        'mobileNumber': authProvider.currentUser!.phone,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StudentRegisterWidget(
      isLoading: isLoading,
      registerStudent: registerStudent,
    );
  }
}
