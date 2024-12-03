import 'package:attendance_app/routes/attendance_app_routes.dart';
import 'package:attendance_app/themes/colors.dart';
import 'package:attendance_app/widgets/common/icon_text_button.dart';
import 'package:attendance_app/widgets/common/svg_lodder.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/resources/icons.dart' as icons;

import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/themes/fonts.dart';
import 'package:attendance_app/widgets/attendance/course_detail_widget.dart';
import 'package:intl/intl.dart';

class AttendanceWidget extends StatefulWidget {
  const AttendanceWidget({
    super.key,
    required this.course,
    required this.displayFormatDate,
    required this.studentsAttendanceStatus,
    required this.fetchAttendance,
    required this.teachersAttendanceStatus,
  });

  final CourseModel course;

  final Map<String, bool> studentsAttendanceStatus;
  final Map<String, bool> teachersAttendanceStatus;
  final void Function(String, String) fetchAttendance;
  final String displayFormatDate;

  @override
  State<AttendanceWidget> createState() => _ItemDetailWidgetState();
}

class _ItemDetailWidgetState extends State<AttendanceWidget> {
  late Map<String, bool> attendanceStatus;
  late Map<String, bool> teachersAttendanceStatus;
  final String todayDate = DateFormat('ddMMyyyy').format(DateTime.now());
  final String todayDateFormat =
      DateFormat('dd/MM/yyyy').format(DateTime.now());
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    attendanceStatus = widget.studentsAttendanceStatus;
    teachersAttendanceStatus = widget.teachersAttendanceStatus;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      Strings.totalRegistration,
                      style: Theme.of(context).textTheme.bodyLargePrimaryBold,
                    ),
                    const Spacer(),
                    IconTextButton(
                      text: Strings.dashBoard,
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          AttendanceAppRoutes.studentCourseDashboard,
                          arguments: widget.course,
                        );
                      },
                      color: ThemeColors.primary,
                      iconHorizontalPadding: 10,
                    ),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Students : ",
                          style:
                              Theme.of(context).textTheme.bodyMediumTitleBrown,
                        ),
                        Text(
                          widget.course.noOfRegistrations.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMediumTitleBrownSemiBold,
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(
                          "Teachers : ",
                          style:
                              Theme.of(context).textTheme.bodyMediumTitleBrown,
                        ),
                        Text(
                          widget.course.noOfTeachersRegistrations.toString(),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMediumTitleBrownSemiBold,
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          CourseDetailWidget(course: widget.course),
          if (widget.course.noOfTeachersRegistrations! > 0 ||
              widget.course.noOfRegistrations! > 0)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: widget.displayFormatDate == todayDateFormat
                      ? const EdgeInsets.all(0)
                      : const EdgeInsets.symmetric(horizontal: 10),
                  child: InkWell(
                    child: const SVGLoader(
                      image: icons.Icons.prev,
                      width: 20,
                      height: 20,
                    ),
                    onTap: () {
                      DateTime dayBeforeYesterday =
                          DateTime.now().subtract(const Duration(days: 2));
                      String dayBeforeYesterdayDate =
                          DateFormat('ddMMyyyy').format(dayBeforeYesterday);
                      String dayBeforeYesterdayDateDisplayFormat =
                          DateFormat('dd/MM/yyyy').format(dayBeforeYesterday);
                      widget.fetchAttendance(
                        dayBeforeYesterdayDate,
                        dayBeforeYesterdayDateDisplayFormat,
                      );
                    },
                  ),
                ),
                if (widget.displayFormatDate == todayDateFormat)
                  InkWell(
                    child: Icon(
                      Icons.navigate_before,
                      color: ThemeColors.primary,
                    ),
                    onTap: () {
                      DateTime yesterday =
                          DateTime.now().subtract(const Duration(days: 1));

                      String yesterdayDate =
                          DateFormat('ddMMyyyy').format(yesterday);
                      String yesterdayDateDisplayFormat =
                          DateFormat('dd/MM/yyyy').format(yesterday);
                      widget.fetchAttendance(
                        yesterdayDate,
                        yesterdayDateDisplayFormat,
                      );
                    },
                  ),
                Text(
                  widget.displayFormatDate,
                  style: Theme.of(context).textTheme.bodyMediumPrimary,
                ),
                if (widget.displayFormatDate != todayDateFormat)
                  InkWell(
                    child: Icon(
                      Icons.navigate_next,
                      color: ThemeColors.primary,
                    ),
                    onTap: () {
                      widget.fetchAttendance(
                        todayDate,
                        todayDateFormat,
                      );
                    },
                  ),
              ],
            ),
          if (widget.course.noOfTeachersRegistrations! > 0)
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Strings.teacherNames,
                        style: Theme.of(context).textTheme.bodyLargePrimaryBold,
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.course.teachers!.length,
                      itemBuilder: (ctx, index) {
                        final teacher = widget.course.teachers![index];
                        final teacherId = teacher.keys.first;
                        final teacherName = teacher.values.first;
                        final isPresent =
                            teachersAttendanceStatus[teacherId] ?? false;

                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                teacherName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMediumTitleBrownSemiBold,
                              ),
                              Switch(
                                value: isPresent,
                                onChanged: (value) {},
                                activeColor: Colors.green,
                                inactiveThumbColor:
                                    const Color.fromARGB(255, 117, 0, 0),
                                inactiveTrackColor: Colors.red,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          if (widget.course.noOfRegistrations! > 0)
            Container(
              margin: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        Strings.studentNames,
                        style: Theme.of(context).textTheme.bodyLargePrimaryBold,
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListView.builder(
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.course.students!.length,
                      itemBuilder: (ctx, index) {
                        final student = widget.course.students![index];
                        final studentId = student.keys.first;
                        final studentName = student.values.first;
                        final isPresent = attendanceStatus[studentId] ?? false;

                        return Container(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                studentName,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMediumTitleBrownSemiBold,
                              ),
                              Switch(
                                value: isPresent,
                                onChanged: (value) {},
                                activeColor: Colors.green,
                                inactiveThumbColor:
                                    const Color.fromARGB(255, 117, 0, 0),
                                inactiveTrackColor: Colors.red,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}
