import 'package:flutter/material.dart';

import 'package:location_app/widgets/admin/resolved_enquiry_screen_widget.dart';
import 'package:location_app/core/services/enquiry/enquiry_service.dart';
import 'package:location_app/models/enquiry/enquiry_model.dart';
import 'package:location_app/providers/auth_provider.dart';

import 'package:provider/provider.dart';

class ResolvedEnquiryScreenContainer extends StatefulWidget {
  const ResolvedEnquiryScreenContainer({super.key});

  @override
  State<ResolvedEnquiryScreenContainer> createState() =>
      _ReceptionEnquiryContainerState();
}

class _ReceptionEnquiryContainerState
    extends State<ResolvedEnquiryScreenContainer> {
  bool _isLoading = false;
  final _enquiryService = EnquiryService();
  List<EnquiryModel> _enquiries = [];

  void fetchEnquiries() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    _enquiryService
        .getResolvedEnquiries(authProvider.currentUser!.institute[0])
        .listen((enquiries) {
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
    return ResolvedEnquiryScreenWidget(
      isLoading: _isLoading,
      enquiries: _enquiries,
    );
  }
}
