import 'package:flutter/material.dart';
import 'package:menu_app/core/services/courses/course_service.dart';
import 'package:menu_app/models/courses/course_model.dart';
import 'package:menu_app/providers/auth_provider.dart';
import 'package:menu_app/routes/admin_routes.dart';
import 'package:menu_app/utils/show_snackbar.dart';
import 'package:menu_app/widgets/admin/course_migration_widget.dart';
import 'package:provider/provider.dart';

class CourseMigrationContainer extends StatefulWidget {
  final List<String> courseIds;
  final String oldCourseId;
  const CourseMigrationContainer({
    super.key,
    required this.courseIds,
    required this.oldCourseId,
  });

  @override
  State<CourseMigrationContainer> createState() =>
      _CourseMigrationContainerState();
}

class _CourseMigrationContainerState extends State<CourseMigrationContainer> {
  bool _isLoading = true;
  CourseService courseService = CourseService();
  List<CourseModel> alternateCourses = [];

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  void fetchCourses() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final response = await courseService.fetchListedCourses(
      authProvider.currentUser!.institute.first,
      widget.courseIds,
    );
    setState(() {
      _isLoading = false;
      alternateCourses = response;
    });
  }

  void migrateCourse(String courseId) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final response = await courseService.migrateCourse(
      authProvider.currentUser!.institute.first,
      courseId,
      widget.oldCourseId,
    );
    if (response) {
      showSnackbar(context, "Course migrated successfully");
      Navigator.of(context).pushReplacementNamed(
        arguments: {
          'category': 'courses',
          'showBack': true,
        },
        AdminRoutes.itemList,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : CourseMigrationWidget(
            myCourses: alternateCourses,
            migrateCourse: migrateCourse,
          );
  }
}
