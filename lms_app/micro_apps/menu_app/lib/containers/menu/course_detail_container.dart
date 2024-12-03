import 'package:flutter/material.dart';
import 'package:menu_app/constants/enums/user_role_enum.dart';
import 'package:menu_app/core/services/courses/course_service.dart';
import 'package:menu_app/models/courses/course_model.dart';
import 'package:menu_app/providers/auth_provider.dart';
import 'package:menu_app/routes/admin_routes.dart';
import 'package:menu_app/utils/show_snackbar.dart';

import 'package:menu_app/widgets/menu/course_detail_widget.dart';
import 'package:provider/provider.dart';

class CourseDetailContainer extends StatefulWidget {
  const CourseDetailContainer({
    super.key,
    required this.course,
    required this.subCategory,
  });

  final CourseModel course;
  final String subCategory;

  @override
  State<CourseDetailContainer> createState() => _CourseDetailContainerState();
}

class _CourseDetailContainerState extends State<CourseDetailContainer> {
  bool _isLoading = true;
  int _approvedRegistrationsCount = 0;
  int _pendingRegistrationsCount = 0;
  int _rejectedRegistrationsCount = 0;

  Future<void> fetchCourseStatus() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final courseService = CourseService();
    final courseId = widget.course.courseId;
    final role = authProvider.currentUser!.role;

    if (role == UserRoleEnum.admin.roleName) {
      final instituteCode = authProvider.currentUser!.institute.first;
      final results = await Future.wait([
        courseService.getApprovedRegistrationsCount(instituteCode, courseId),
        courseService.getPendingRegistrationsCount(instituteCode, courseId),
        courseService.getRejectedRegistrationsCount(instituteCode, courseId),
      ]);

      setState(() {
        _approvedRegistrationsCount = results[0];
        _pendingRegistrationsCount = results[1];
        _rejectedRegistrationsCount = results[2];
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<List<String>> checkForEistingCourse() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final courseService = CourseService();
    final response = await courseService.checkExistingCourse(
      authProvider.currentUser!.institute.first,
      widget.course.courseTitle,
      widget.course.courseId,
    );
    return response;
  }

  void deleteCourse() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final courseService = CourseService();
    final courseId = widget.course.courseId;
    final instituteCode = authProvider.currentUser!.institute.first;
    final response = await courseService.deleteCourse(instituteCode, courseId);
    if (response) {
      showSnackbar(context, "Course deleted successfully");
      Navigator.of(context).pushReplacementNamed(
        arguments: {
          'category': widget.subCategory,
          'showBack': true,
        },
        AdminRoutes.itemList,
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCourseStatus();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : CourseDetailWidget(
            course: widget.course,
            subCategory: widget.subCategory,
            approvedRegistrationsCount: _approvedRegistrationsCount,
            pendingRegistrationsCount: _pendingRegistrationsCount,
            rejectedRegistrationsCount: _rejectedRegistrationsCount,
            deleteCourse: deleteCourse,
            checkForEistingCourse: checkForEistingCourse,
          );
  }
}
