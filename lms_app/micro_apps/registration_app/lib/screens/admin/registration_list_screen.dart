import 'package:flutter/material.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/widgets/admin/registration_list_widget.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';

class RegistrationListScreen extends StatelessWidget {
  const RegistrationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      showBackButton: false,
      topBarText: Strings.registrationList,
      child: RegistrationListWidget(),
    );
  }
}
