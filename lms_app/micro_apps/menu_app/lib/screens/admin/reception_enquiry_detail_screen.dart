import 'package:flutter/material.dart';
import 'package:menu_app/containers/admin/reception_enquiry_detail_container.dart';
import 'package:menu_app/models/enquiry/enquiry_model.dart';
import 'package:menu_app/resources/strings.dart';

import 'package:menu_app/widgets/menu/menu_layout.dart';

class ReceptionEnquiryDetailScreen extends StatelessWidget {
  const ReceptionEnquiryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final enquiry = ModalRoute.of(context)!.settings.arguments as EnquiryModel;

    return MenuLayout(
      topBarText: Strings.receptionEnquiry,
      child: ReceptionEnquiryDetailContainer(
        enquiry: enquiry,
      ),
    );
  }
}
