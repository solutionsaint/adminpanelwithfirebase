import 'package:flutter/material.dart';

import 'package:menu_app/containers/admin/resolved_enquiry_screen_container.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/widgets/menu/menu_layout.dart';

class ResolvedEnquiryScreen extends StatelessWidget {
  const ResolvedEnquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MenuLayout(
      topBarText: Strings.resolvedHistory,
      child: ResolvedEnquiryScreenContainer(),
    );
  }
}
