import 'package:flutter/material.dart';
import 'package:attendance_app/core/services/enquiry/enquiry_service.dart';
import 'package:attendance_app/models/enquiry/enquiry_model.dart';
import 'package:attendance_app/providers/auth_provider.dart';

import 'package:attendance_app/widgets/admin/reception_enquiry_widget.dart';
import 'package:provider/provider.dart';

class ReceptionEnquiryContainer extends StatefulWidget {
  const ReceptionEnquiryContainer({super.key});

  @override
  State<ReceptionEnquiryContainer> createState() =>
      _ReceptionEnquiryContainerState();
}

class _ReceptionEnquiryContainerState extends State<ReceptionEnquiryContainer> {
  bool _isLoading = false;
  final _enquiryService = EnquiryService();
  List<EnquiryModel> _enquiries = [];

  void fetchEnquiries() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _enquiryService.getEnquiries(authProvider.currentUser!.institute[0]).listen(
        (enquiries) {
      setState(() {
        _enquiries = enquiries;
      });
    }, onError: (error) {
      setState(() {
        _isLoading = false;
      });
      print('Error fetching enquiries: $error');
    });
  }

  @override
  void initState() {
    super.initState();
    fetchEnquiries();
  }

  @override
  Widget build(BuildContext context) {
    return ReceptionEnquiryWidget(
      isLoading: _isLoading,
      enquiries: _enquiries,
    );
  }
}
