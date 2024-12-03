import 'package:enquiry_app/widgets/common/screen_layout.dart';
import 'package:flutter/material.dart';

import 'package:enquiry_app/containers/admin/reception_enquiry_container.dart';
import 'package:enquiry_app/resources/strings.dart';

class ReceptionEnquiryScreen extends StatelessWidget {
  const ReceptionEnquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      topBarText: Strings.receptionEnquiry,
      showBackButton: false,
      child: ReceptionEnquiryContainer(),
    );
  }
}
