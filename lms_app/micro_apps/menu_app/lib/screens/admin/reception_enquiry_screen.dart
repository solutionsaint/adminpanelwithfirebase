import 'package:flutter/material.dart';

import 'package:menu_app/containers/admin/reception_enquiry_container.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/widgets/menu/menu_layout.dart';

class ReceptionEnquiryScreen extends StatelessWidget {
  const ReceptionEnquiryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MenuLayout(
      topBarText: Strings.receptionEnquiry,
      child: ReceptionEnquiryContainer(),
    );
  }
}
