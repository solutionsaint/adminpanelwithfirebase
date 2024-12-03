import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/core/services/courses/course_service.dart';
import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/providers/auth_provider.dart';

import 'package:registration_app/widgets/student/student_item_list_widget.dart';

class StudentItemListContainer extends StatefulWidget {
  const StudentItemListContainer({super.key});

  @override
  State<StudentItemListContainer> createState() =>
      _StudentItemListContainerState();
}

class _StudentItemListContainerState extends State<StudentItemListContainer> {
  bool _isLoading = true;
  final _courseService = CourseService();
  List<CourseModel> courses = [];

  void fetchItems() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _courseService
        .getCourses(
      authProvider.selectedinstituteCode,
      authProvider.currentUser!.uid,
    )
        .listen((courses) {
      setState(() {
        _isLoading = false;
        this.courses = courses;
      });
    }, onError: (error) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching courses: $error');
    });
  }

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return StudentItemListWidget(isLoading: _isLoading, courses: courses);
  }
}
