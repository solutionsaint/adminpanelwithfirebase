import 'package:flutter/material.dart';

import 'package:location_app/containers/admin/resolved_enquiry_screen_container.dart';
import 'package:location_app/resources/strings.dart';
import 'package:location_app/widgets/common/screen_layout.dart';

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
