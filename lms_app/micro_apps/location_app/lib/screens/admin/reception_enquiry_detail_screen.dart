import 'package:flutter/material.dart';

import 'package:location_app/containers/admin/reception_enquiry_detail_container.dart';
import 'package:location_app/models/enquiry/enquiry_model.dart';
import 'package:location_app/resources/strings.dart';
import 'package:location_app/widgets/common/screen_layout.dart';

class ReceptionEnquiryDetailScreen extends StatelessWidget {
  const ReceptionEnquiryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final enquiry = ModalRoute.of(context)!.settings.arguments as EnquiryModel;

    return ScreenLayout(
      topBarText: Strings.locationEnquiry,
      child: ReceptionEnquiryDetailContainer(
        enquiry: enquiry,
      ),
    );
  }
}
