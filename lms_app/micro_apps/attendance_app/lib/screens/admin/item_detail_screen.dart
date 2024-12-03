import 'package:flutter/material.dart';

import 'package:attendance_app/containers/admin/item_detail_container.dart';
import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/widgets/attendance/attendance_layout.dart';

class ItemDetailScreen extends StatelessWidget {
  const ItemDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CourseModel course =
        ModalRoute.of(context)!.settings.arguments as CourseModel;

    return AttendanceLayout(
      bottomText: "Item Detail",
      topBarText: "Item Detail",
      child: ItemDetailContainer(course: course),
    );
  }
}
