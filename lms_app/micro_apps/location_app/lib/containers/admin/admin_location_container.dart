import 'package:flutter/material.dart';
import 'package:location_app/core/services/firebase/location_service.dart';
import 'package:location_app/models/location_model.dart';
import 'package:location_app/providers/auth_provider.dart';
import 'package:location_app/utils/error/show_snackbar.dart';

import 'package:location_app/widgets/admin/admin_location_widget.dart';
import 'package:provider/provider.dart';

class AdminLocationContainer extends StatefulWidget {
  const AdminLocationContainer({super.key});

  @override
  State<AdminLocationContainer> createState() => _AdminLocationContainerState();
}

class _AdminLocationContainerState extends State<AdminLocationContainer> {
  bool _isLoading = false;

  Future<void> storeLocation(LocationModel location) async {
    final locationService = LocationService();

    setState(() {
      _isLoading = true;
    });
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final response = await locationService.addLocation(
      location,
      authProvider.currentUser?.institute.first ?? '',
    );
    if (response != null) {
      showSnackbar(context, 'Location added successfully');
    } else {
      showSnackbar(context, 'Error adding location');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AdminLocationWidget(
      isLoading: _isLoading,
      storeLocation: storeLocation,
    );
  }
}
