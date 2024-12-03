import 'package:flutter/material.dart';

import 'package:enquiry_app/containers/student_teacher/raise_enquiry_container.dart';
import 'package:enquiry_app/resources/strings.dart';
import 'package:enquiry_app/widgets/common/screen_layout.dart';

class RaiseEnquiryScreen extends StatelessWidget {
  const RaiseEnquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      showBackButton: false,
      topBarText: Strings.raiseEnquiry,
      child: RaiseEnquiryContainer(),
    );
  }
}
