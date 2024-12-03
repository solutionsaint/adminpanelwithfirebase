import 'package:enquiry_app/containers/student_teacher/my_ticket_container.dart';
import 'package:enquiry_app/models/enquiry/enquiry_model.dart';
import 'package:enquiry_app/resources/strings.dart';
import 'package:enquiry_app/widgets/common/screen_layout.dart';
import 'package:flutter/material.dart';

class MyTicketScreen extends StatelessWidget {
  const MyTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final EnquiryModel enquiry =
        ModalRoute.of(context)!.settings.arguments as EnquiryModel;

    return ScreenLayout(
      topBarText: Strings.myTicket,
      child: MyTicketContainer(
        enquiry: enquiry,
      ),
    );
  }
}
