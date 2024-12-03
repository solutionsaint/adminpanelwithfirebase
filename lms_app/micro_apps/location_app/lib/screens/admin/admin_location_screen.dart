import 'package:flutter/material.dart';

import 'package:location_app/containers/admin/admin_location_container.dart';
import 'package:location_app/resources/strings.dart';
import 'package:location_app/widgets/common/screen_layout.dart';

class AdminLocationScreen extends StatelessWidget {
  const AdminLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      topBarText: Strings.location,
      bottomText: Strings.myLocation,
      showBackButton: false,
      child: AdminLocationContainer(),
    );
  }
}
