import 'dart:io';

import 'package:enquiry_app/core/services/enquiry/enquiry_service.dart';
import 'package:enquiry_app/providers/auth_provider.dart';
import 'package:enquiry_app/resources/strings.dart';
import 'package:enquiry_app/utils/error/show_snackbar.dart';
import 'package:flutter/material.dart';

import 'package:enquiry_app/widgets/student_teacher/enquiry_reception_widget.dart';
import 'package:provider/provider.dart';

class EnquiryReceptionContainer extends StatefulWidget {
  const EnquiryReceptionContainer({
    super.key,
    required this.type,
  });

  final String type;

  @override
  State<EnquiryReceptionContainer> createState() =>
      _EnquiryReceptionContainerState();
}

class _EnquiryReceptionContainerState extends State<EnquiryReceptionContainer> {
  late String name;

  @override
  void initState() {
    super.initState();
    getDetails();
  }

  Future<void> getDetails() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      name = authProvider.currentUser!.name;
    });
  }

  EnquiryService _enquiryService = EnquiryService();

  Future<void> createEnquiry(
    String issue,
    String subject,
    String description,
    String priority,
    File? file,
  ) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    String userId = authProvider.currentUser!.uid;
    String instituteId = authProvider.selectedinstituteCode;

    final response = await _enquiryService.createEnquiry(
      issue,
      subject,
      description,
      priority,
      userId,
      instituteId,
      widget.type,
      file,
    );

    if (response != null && response.isNotEmpty) {
      showSnackbar(context, Strings.ticketCreatedSuccessfully);
      Navigator.of(context).pop();
    } else {
      showSnackbar(context, Strings.ticketCreationFailed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return EnquiryReceptionWidget(
      name: name,
      onCreateEnquiry: createEnquiry,
    );
  }
}
