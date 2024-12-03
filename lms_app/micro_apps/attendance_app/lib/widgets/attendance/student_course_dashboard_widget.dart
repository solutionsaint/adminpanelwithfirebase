import 'package:attendance_app/core/services/attendance/attendance_service.dart';
import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/themes/fonts.dart';
import 'package:attendance_app/widgets/attendance/student_dashboard_card_widget.dart';
import 'package:flutter/material.dart';

class StudentCourseDashboardWidget extends StatefulWidget {
  const StudentCourseDashboardWidget({
    super.key,
    required this.course,
  });

  final CourseModel course;

  @override
  StudentDashboardWidgetState createState() => StudentDashboardWidgetState();
}

class StudentDashboardWidgetState extends State<StudentCourseDashboardWidget> {
  bool _isAscendingStudents = true;
  bool _isAscendingTeachers = true;
  List<Map<String, dynamic>>? _studentsData;
  List<Map<String, dynamic>>? _teachersData;
  bool _isLoading = true;

  Future<void> fetchStudentsData() async {
    List<Map<String, dynamic>> studentsData = await Future.wait(
      widget.course.students!.map((student) async {
        final studentId = student.keys.first;
        final studentName = await getStudentName(studentId);
        final attendedHours = await getAttendedHours(studentId);
        return {
          'id': studentId,
          'name': studentName,
          'attendedHours': attendedHours,
        };
      }).toList(),
    );

    setState(() {
      _studentsData = studentsData;
      _isLoading = false;
    });
  }

  Future<void> fetchTeachersData() async {
    List<Map<String, dynamic>> teachersData = await Future.wait(
      widget.course.teachers!.map((teacher) async {
        final teacherId = teacher.keys.first;
        final teacherName = await getStudentName(teacherId);
        final attendedHours = await getAttendedHours(teacherId);
        return {
          'id': teacherId,
          'name': teacherName,
          'attendedHours': attendedHours,
        };
      }).toList(),
    );

    setState(() {
      _teachersData = teachersData;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchStudentsData();
    fetchTeachersData();
  }

  Future<int> getAttendedHours(String id) async {
    AttendanceService attendanceService = AttendanceService();
    return await attendanceService.attendedHours(id, widget.course.courseId);
  }

  Future<String> getStudentName(String id) async {
    AttendanceService attendanceService = AttendanceService();
    return await attendanceService.getStudentName(id);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    // Show loading indicator when data is being fetched
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    // Check if both _studentsData and _teachersData are null or empty
    if ((_studentsData == null || _studentsData!.isEmpty) &&
        (_teachersData == null || _teachersData!.isEmpty)) {
      return Center(
        child: Text(
          "No Data Found",
          style: Theme.of(context).textTheme.bodyMediumTitleBrown,
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          _isLoading = true;
        });

        await Future.wait([fetchStudentsData(), fetchTeachersData()]);

        setState(() {
          _isLoading = false;
        });
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Container(
          width: screenSize.width * 0.9,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            children: [
              const SizedBox(height: 10),
              // Students section
              if (_studentsData != null && _studentsData!.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Students",
                      style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                    ),
                    Row(
                      children: [
                        Text(
                          "Sort By",
                          style:
                              Theme.of(context).textTheme.bodyMediumTitleBrown,
                        ),
                        const SizedBox(width: 15),
                        DropdownButton<String>(
                          value:
                              _isAscendingStudents ? "Ascending" : "Descending",
                          icon: const Icon(Icons.arrow_drop_down),
                          padding: const EdgeInsets.all(0),
                          style: Theme.of(context)
                              .textTheme
                              .displayMediumTitleBrownSemiBold,
                          items: const [
                            DropdownMenuItem(
                              value: "Ascending",
                              child: Text('Ascending'),
                            ),
                            DropdownMenuItem(
                              value: "Descending",
                              child: Text('Descending'),
                            ),
                          ],
                          onChanged: (String? newValue) {
                            setState(() {
                              _isAscendingStudents = (newValue == "Ascending");
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _studentsData!.length,
                  itemBuilder: (ctx, index) {
                    List<Map<String, dynamic>> sortedStudentsData =
                        List.from(_studentsData!);

                    sortedStudentsData.sort((a, b) {
                      return _isAscendingStudents
                          ? a['attendedHours'].compareTo(b['attendedHours'])
                          : b['attendedHours'].compareTo(a['attendedHours']);
                    });

                    final studentData = sortedStudentsData[index];
                    return StudentDashboardCardWidget(
                      course: widget.course,
                      attendedHours: studentData['attendedHours'],
                      name: studentData['name'],
                      studentId: studentData['id'],
                    );
                  },
                ),
              ],

              const SizedBox(height: 20),

              // Teachers section
              if (_teachersData != null && _teachersData!.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Teachers",
                      style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                    ),
                    Row(
                      children: [
                        Text(
                          "Sort By",
                          style:
                              Theme.of(context).textTheme.bodyMediumTitleBrown,
                        ),
                        const SizedBox(width: 15),
                        DropdownButton<String>(
                          value:
                              _isAscendingTeachers ? "Ascending" : "Descending",
                          icon: const Icon(Icons.arrow_drop_down),
                          padding: const EdgeInsets.all(0),
                          style: Theme.of(context)
                              .textTheme
                              .displayMediumTitleBrownSemiBold,
                          items: const [
                            DropdownMenuItem(
                              value: "Ascending",
                              child: Text('Ascending'),
                            ),
                            DropdownMenuItem(
                              value: "Descending",
                              child: Text('Descending'),
                            ),
                          ],
                          onChanged: (String? newValue) {
                            setState(() {
                              _isAscendingTeachers = (newValue == "Ascending");
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
                ListView.builder(
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _teachersData!.length,
                  itemBuilder: (ctx, index) {
                    List<Map<String, dynamic>> sortedTeachersData =
                        List.from(_teachersData!);

                    sortedTeachersData.sort((a, b) {
                      return _isAscendingTeachers
                          ? a['attendedHours'].compareTo(b['attendedHours'])
                          : b['attendedHours'].compareTo(a['attendedHours']);
                    });

                    final teacherData = sortedTeachersData[index];
                    return StudentDashboardCardWidget(
                      course: widget.course,
                      attendedHours: teacherData['attendedHours'],
                      name: teacherData['name'],
                      studentId: teacherData['id'],
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
