import 'package:flutter/material.dart';

import 'package:location_app/containers/admin/reception_enquiry_container.dart';
import 'package:location_app/resources/strings.dart';
import 'package:location_app/widgets/common/screen_layout.dart';

class ReceptionEnquiryScreen extends StatelessWidget {
  const ReceptionEnquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      topBarText: Strings.locationEnquiry,
      child: ReceptionEnquiryContainer(),
    );
  }
}
