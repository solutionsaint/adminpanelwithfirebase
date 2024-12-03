import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:attendance_app/models/courses/display_attendance_model.dart';
import 'package:attendance_app/themes/colors.dart';
import 'package:attendance_app/themes/fonts.dart';
import 'package:attendance_app/widgets/common/icon_text_button.dart';

class AttendanceChangesWidget extends StatefulWidget {
  const AttendanceChangesWidget({
    super.key,
    required this.attendances,
    required this.onUpdateAttendance,
    required this.isLoading,
  });

  final List<DisplayAttendanceModel> attendances;
  final void Function(List<DisplayAttendanceModel>) onUpdateAttendance;
  final bool isLoading;

  @override
  State<AttendanceChangesWidget> createState() =>
      _AttendanceChangesWidgetState();
}

class _AttendanceChangesWidgetState extends State<AttendanceChangesWidget> {
  List<DisplayAttendanceModel> attendanceUpdates = [];

  String formatDate(String dateString) {
    try {
      final day = dateString.substring(0, 2);
      final month = dateString.substring(2, 4);
      final year = dateString.substring(4, 8);

      final date = DateTime(int.parse(year), int.parse(month), int.parse(day));

      return DateFormat('dd/MM/yyyy').format(date);
    } catch (e) {
      print('Error formatting date: $e');
      return 'Invalid Date';
    }
  }

  String formatDateForUpdate(String dateString) {
    try {
      final day = dateString.substring(0, 2);
      final month = dateString.substring(3, 5);
      final year = dateString.substring(6, 10);

      return '$day$month$year';
    } catch (e) {
      print('Error formatting date for update: $e');
      return 'Invalid Date';
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      width: screenSize.width * 0.9,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: widget.attendances.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: widget.attendances.length,
                    itemBuilder: (ctx, index) {
                      final formattedDate =
                          formatDate(widget.attendances[index].date.trim());
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formattedDate,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMediumTitleBrownSemiBold,
                            ),
                            Switch(
                              value: widget.attendances[index].status,
                              onChanged: (value) {
                                setState(() {
                                  final updatedAttendance =
                                      DisplayAttendanceModel(
                                    date: widget.attendances[index].date,
                                    status: value,
                                  );

                                  widget.attendances[index] = updatedAttendance;

                                  int existingIndex =
                                      attendanceUpdates.indexWhere((element) =>
                                          element.date ==
                                          widget.attendances[index].date);

                                  if (existingIndex >= 0) {
                                    attendanceUpdates[existingIndex] =
                                        updatedAttendance;
                                  } else {
                                    attendanceUpdates.add(updatedAttendance);
                                  }
                                });
                              },
                              activeColor: Colors.green,
                              inactiveThumbColor:
                                  const Color.fromARGB(255, 117, 0, 0),
                              inactiveTrackColor: Colors.red,
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Text(
                    "No Attendances to Update",
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
          ),
          if (widget.attendances.isNotEmpty)
            SizedBox(
              width: screenSize.width * 0.5,
              height: 50,
              child: IconTextButton(
                isLoading: widget.isLoading,
                iconHorizontalPadding: 5,
                radius: 20,
                text: "Submit",
                onPressed: () {
                  widget.onUpdateAttendance(attendanceUpdates);
                },
                color: ThemeColors.primary,
                buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
        ],
      ),
    );
  }
}
