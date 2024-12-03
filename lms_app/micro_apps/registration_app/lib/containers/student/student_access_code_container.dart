import 'package:flutter/material.dart';
import 'package:registration_app/constants/constants.dart';

import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/routes/student_routes.dart';
import 'package:registration_app/utils/shared_preference/shared_preference.dart';
import 'package:registration_app/utils/show_snackbar.dart';
import 'package:registration_app/widgets/student/student_access_code_widget.dart';
import 'package:provider/provider.dart';

class StudentAccessCodeContainer extends StatefulWidget {
  const StudentAccessCodeContainer({super.key});

  @override
  State<StudentAccessCodeContainer> createState() =>
      _StudentAccessCodeContainerState();
}

class _StudentAccessCodeContainerState
    extends State<StudentAccessCodeContainer> {
  bool _isLoading = false;
  String? existingAccessCode;

  void navigateToHomeNavigation() {
    Navigator.of(context).pushNamed(StudentRoutes.itemList);
  }

  void onInstituteSelection(String instituteCode) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    setState(() {
      _isLoading = true;
    });
    final response =
        await authProvider.checkExistingInstituteCode(instituteCode.trim());
    setState(() {
      _isLoading = false;
    });
    await SharedPreferencesUtils()
        .addMapPrefs(accessCodeConstants.accessCodeFlag, {
      "accessCode": instituteCode,
    });
    if (response) {
      navigateToHomeNavigation();
    } else {
      showSnackbar(context, "Fetching failed");
    }
  }

  void checkExistingAccessCode() async {
    setState(() {
      _isLoading = true;
    });
    final accessCodeStatus = await SharedPreferencesUtils().getMapPrefs(
      accessCodeConstants.accessCodeFlag,
    );
    setState(() {
      existingAccessCode = accessCodeStatus.value != null
          ? accessCodeStatus.value['accessCode']
          : null;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    checkExistingAccessCode();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : StudentAccessCodeWidget(
            isLoading: _isLoading,
            onInstituteSelection: onInstituteSelection,
            existingAccessCode: existingAccessCode,
          );
  }
}
