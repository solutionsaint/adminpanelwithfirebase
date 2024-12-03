import 'package:attendance_app/containers/admin/resolved_enquiry_screen_container.dart';
import 'package:attendance_app/widgets/attendance/attendance_layout.dart';
import 'package:flutter/material.dart';

import 'package:attendance_app/resources/strings.dart';

class ResolvedEnquiryScreen extends StatelessWidget {
  const ResolvedEnquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AttendanceLayout(
      topBarText: Strings.resolvedHistory,
      child: ResolvedEnquiryScreenContainer(),
    );
  }
}
