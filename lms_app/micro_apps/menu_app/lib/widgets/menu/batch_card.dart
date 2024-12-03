import 'package:flutter/material.dart';
import 'package:menu_app/models/courses/course_model.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/widgets/common/drop_down_row.dart';

class BatchCard extends StatefulWidget {
  const BatchCard({
    super.key,
    required this.role,
    required this.course,
  });

  final String role;
  final CourseModel course;

  @override
  _BatchCardState createState() => _BatchCardState();
}

class _BatchCardState extends State<BatchCard> {
  late String selectedBatchDays;
  late List<String> selectedBatchTime;

  @override
  void initState() {
    super.initState();
    selectedBatchDays = widget.course.batchDay;
    selectedBatchTime = [widget.course.batchTime!]; // Default value
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: ThemeColors.cardColor,
        boxShadow: [
          BoxShadow(
            color: ThemeColors.black.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SizedBox(
        height: 140.0,
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: ThemeColors.cardBorderColor,
                    width: 0.3,
                  ),
                ),
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropDownRow(
                      label: Strings.days,
                      value: selectedBatchDays,
                      options: [selectedBatchDays],
                      onChanged: (String? newValue) {},
                      isDropdown: true,
                    ),
                    const SizedBox(height: 20),
                    DropDownRow(
                      label: Strings.time,
                      value: selectedBatchTime[0],
                      options: selectedBatchTime,
                      onChanged: (String? newValue) {},
                      isDropdown: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
