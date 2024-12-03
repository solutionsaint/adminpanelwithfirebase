import 'package:enquiry_app/widgets/common/screen_layout.dart';
import 'package:flutter/material.dart';
import 'package:enquiry_app/containers/admin/reception_enquiry_detail_container.dart';
import 'package:enquiry_app/models/enquiry/enquiry_model.dart';
import 'package:enquiry_app/resources/strings.dart';

class ReceptionEnquiryDetailScreen extends StatelessWidget {
  const ReceptionEnquiryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final enquiry = ModalRoute.of(context)!.settings.arguments as EnquiryModel;

    return ScreenLayout(
      topBarText: Strings.receptionEnquiry,
      child: ReceptionEnquiryDetailContainer(
        enquiry: enquiry,
      ),
    );
  }
}
