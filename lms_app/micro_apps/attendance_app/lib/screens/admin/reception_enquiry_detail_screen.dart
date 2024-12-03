import 'package:attendance_app/widgets/attendance/attendance_layout.dart';
import 'package:flutter/material.dart';
import 'package:attendance_app/containers/admin/reception_enquiry_detail_container.dart';
import 'package:attendance_app/models/enquiry/enquiry_model.dart';
import 'package:attendance_app/resources/strings.dart';

class ReceptionEnquiryDetailScreen extends StatelessWidget {
  const ReceptionEnquiryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final enquiry = ModalRoute.of(context)!.settings.arguments as EnquiryModel;

    return AttendanceLayout(
      topBarText: Strings.attendanceEnquiry,
      child: ReceptionEnquiryDetailContainer(
        enquiry: enquiry,
      ),
    );
  }
}
