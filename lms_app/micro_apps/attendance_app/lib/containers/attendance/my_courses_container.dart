import 'package:attendance_app/core/services/attendance/attendance_service.dart';
import 'package:attendance_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/widgets/attendance/my_courses_widget.dart';
import 'package:provider/provider.dart';

class MyCoursesContainer extends StatefulWidget {
  const MyCoursesContainer({super.key});

  @override
  State<MyCoursesContainer> createState() => _MyCoursesContainerState();
}

class _MyCoursesContainerState extends State<MyCoursesContainer> {
  List<CourseModel> myCourses = []; // Variable to store fetched courses
  AttendanceService attendanceService = AttendanceService();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchCourses(); // Fetch courses when widget is initialized
  }

  Future<void> _fetchCourses() async {
    setState(() {
      isLoading = true;
    });
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    String userId = authProvider.currentUser!.uid;
    String instituteId = authProvider.selectedinstituteCode;
    String roleType = authProvider.selectedRoleType;
    List<CourseModel> fetchedCourses = await attendanceService.getCourses(
      userId,
      instituteId,
      roleType,
    );
    setState(() {
      isLoading = false;
      myCourses = fetchedCourses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : MyCoursesWidget(myCourses: myCourses); // This will remain as is
  }
}
