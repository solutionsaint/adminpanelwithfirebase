import 'package:enquiry_app/containers/student_teacher/my_tickets_container.dart';
import 'package:flutter/material.dart';

import 'package:enquiry_app/resources/strings.dart';
import 'package:enquiry_app/widgets/common/screen_layout.dart';

class MyTicketsScreen extends StatelessWidget {
  const MyTicketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      topBarText: Strings.myTickets,
      child: MyTicketsContainer(),
    );
  }
}
