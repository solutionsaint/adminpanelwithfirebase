import 'package:attendance_app/widgets/attendance/attendance_layout.dart';
import 'package:flutter/material.dart';

import 'package:attendance_app/containers/admin/reception_enquiry_container.dart';
import 'package:attendance_app/resources/strings.dart';

class ReceptionEnquiryScreen extends StatelessWidget {
  const ReceptionEnquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AttendanceLayout(
      topBarText: Strings.attendanceEnquiry,
      child: ReceptionEnquiryContainer(),
    );
  }
}
