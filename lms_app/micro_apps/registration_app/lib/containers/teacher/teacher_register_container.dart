import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/core/services/registration/registration_service.dart';

import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/routes/teacher_routes.dart';
import 'package:registration_app/utils/show_snackbar.dart';
import 'package:registration_app/widgets/teacher/teacher_register_widget.dart';

class TeacherRegisterContainer extends StatefulWidget {
  const TeacherRegisterContainer({
    super.key,
    required this.course,
    required this.selectedBatchDay,
    required this.selectedBatchTime,
  });

  final CourseModel course;
  final String selectedBatchDay;
  final String selectedBatchTime;

  @override
  State<TeacherRegisterContainer> createState() =>
      _TeacherRegisterContainerState();
}

class _TeacherRegisterContainerState extends State<TeacherRegisterContainer> {
  bool isLoading = false;
  final RegistrationService _registrationService = RegistrationService();

  Future<void> registerCourseForTeacher(
    String batchDay,
    String batchTime,
  ) async {
    setState(() {
      isLoading = true;
    });
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final registrationId = await _registrationService.registerTeacher(
      course: widget.course,
      selectedBatchDay: widget.selectedBatchDay,
      selectedBatchTime: widget.selectedBatchTime,
      registeredBy: authProvider.currentUser!.uid,
      userName: authProvider.currentUser!.name,
      instituteId: authProvider.selectedinstituteCode,
    );
    if (registrationId.isNotEmpty) {
      authProvider.updateRegisteredCoursesList([widget.course.courseId]);
      showSnackbar(context, 'Course registered successfully');
      Navigator.of(context)
          .pushReplacementNamed(TeacherRoutes.enrollment, arguments: {
        'registrationId': registrationId,
        'course': widget.course,
      });
      return;
    } else {
      showSnackbar(context, 'Failed to register course');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TeacherRegisterWidget(
      course: widget.course,
      selectedBatchDay: widget.selectedBatchDay,
      selectedBatchTime: widget.selectedBatchTime,
      onRegisterCourseForTeacher: registerCourseForTeacher,
      isLoading: isLoading,
    );
  }
}
