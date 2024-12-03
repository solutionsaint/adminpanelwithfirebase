import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/routes/student_routes.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/utils/show_snackbar.dart';
import 'package:registration_app/widgets/common/item_card.dart';

class StudentItemListWidget extends StatelessWidget {
  const StudentItemListWidget({
    super.key,
    required this.courses,
    required this.isLoading,
  });

  final List<CourseModel> courses;
  final bool isLoading;

  void navigateToItemDetail(BuildContext context, CourseModel course) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.cart.any((item) => item.courseId == course.courseId)) {
      showSnackbar(context, Strings.courseAlreadyInCart);
      return;
    }
    Navigator.of(context).pushNamed(
      StudentRoutes.itemDetail,
      arguments: course,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final registeredCourses = authProvider.currentUser!.registeredCourses;
    final filteredCourses = courses
        .where((course) => !registeredCourses.contains(course.courseId))
        .toList();

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (filteredCourses.isEmpty) {
      return Center(
          child: Text(
        'No courses found',
        style: TextStyle(color: ThemeColors.primary, fontSize: 18),
      ));
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: filteredCourses.length,
      itemBuilder: (context, index) {
        return ItemCard(
          onPressed: () =>
              navigateToItemDetail(context, filteredCourses[index]),
          course: filteredCourses[index],
        );
      },
    );
  }
}
