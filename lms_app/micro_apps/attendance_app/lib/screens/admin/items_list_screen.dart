import 'package:attendance_app/containers/admin/item_list_container.dart';
import 'package:flutter/material.dart';

import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/widgets/attendance/attendance_layout.dart';

class ItemsListScreen extends StatelessWidget {
  const ItemsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AttendanceLayout(
      topBarText: Strings.itemList,
      bottomText: Strings.item,
      showBackButton: false,
      child: ItemListContainer(),
    );
  }
}
