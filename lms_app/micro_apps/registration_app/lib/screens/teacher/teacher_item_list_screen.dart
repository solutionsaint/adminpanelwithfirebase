import 'package:flutter/material.dart';

import 'package:registration_app/containers/teacher/teacher_item_list_container.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';

class TeacherItemListScreen extends StatelessWidget {
  const TeacherItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      topBarText: Strings.itemList,
      showBackButton: false,
      child: TeacherItemListContainer(),
    );
  }
}
