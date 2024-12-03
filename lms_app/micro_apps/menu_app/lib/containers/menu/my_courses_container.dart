import 'package:flutter/material.dart';
import 'package:menu_app/core/services/courses/course_service.dart';
import 'package:menu_app/models/courses/course_model.dart';
import 'package:menu_app/providers/auth_provider.dart';
import 'package:menu_app/widgets/menu/my_courses_widget.dart';
import 'package:provider/provider.dart';

class MyCoursesContainer extends StatefulWidget {
  const MyCoursesContainer({super.key});

  @override
  State<MyCoursesContainer> createState() => _MyCoursesContainerState();
}

class _MyCoursesContainerState extends State<MyCoursesContainer> {
  bool _isLoading = true;
  final _courseService = CourseService();
  List<CourseModel> courses = [];
  String? subCategory; // Nullable to allow it to be null initially

  void checkCategory() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? selectedCategory = await _courseService
        .hasSelectedCategory(authProvider.selectedinstituteCode);
    if (selectedCategory != null) {
      setState(() {
        subCategory = selectedCategory; // Assign to the instance variable
      });
      fetchItems(subCategory!);
    } else {
      setState(() {
        _isLoading = false; // Set loading to false if no category is selected
      });
    }
  }

  void fetchItems(String selectedSubCategory) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    String instituteId = authProvider.selectedinstituteCode;
    _courseService.getItems(instituteId, subCategory!).listen((courses) {
      setState(() {
        _isLoading = false; // Only set loading to false after data is fetched
        this.courses = courses;
      });
    }, onError: (error) {
      setState(() {
        _isLoading = false; // Ensure loading is set to false if an error occurs
      });
    });
  }

  @override
  void initState() {
    super.initState();
    checkCategory();
  }

  @override
  Widget build(BuildContext context) {
    return MyCoursesWidget(
      isLoading: _isLoading,
      courses: courses,
      subCategory: subCategory ?? '',
    );
  }
}
