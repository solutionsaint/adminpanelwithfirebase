import 'package:flutter/material.dart';

import 'package:enquiry_app/containers/student_teacher/resolved_enquiry_screen_container.dart';
import 'package:enquiry_app/resources/strings.dart';
import 'package:enquiry_app/widgets/common/screen_layout.dart';

class ResolvedEnquiryScreen extends StatelessWidget {
  const ResolvedEnquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      topBarText: Strings.resolvedHistory,
      child: ResolvedEnquiryScreenContainer(),
    );
  }
}
