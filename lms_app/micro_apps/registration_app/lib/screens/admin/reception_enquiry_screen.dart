import 'package:flutter/material.dart';

import 'package:registration_app/containers/admin/reception_enquiry_container.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';

class ReceptionEnquiryScreen extends StatelessWidget {
  const ReceptionEnquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      topBarText: Strings.registrationEnquiry,
      child: ReceptionEnquiryContainer(),
    );
  }
}
