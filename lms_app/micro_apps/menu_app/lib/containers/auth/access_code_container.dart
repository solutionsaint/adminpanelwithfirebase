import 'package:flutter/material.dart';
import 'package:menu_app/constants/constants.dart';

import 'package:menu_app/providers/auth_provider.dart';
import 'package:menu_app/routes/student_teacher_routes.dart';
import 'package:menu_app/utils/shared_preference/shared_preference.dart';
import 'package:menu_app/utils/show_snackbar.dart';
import 'package:menu_app/widgets/access_code_widget.dart';
import 'package:provider/provider.dart';

class AccessCodeContainer extends StatefulWidget {
  const AccessCodeContainer({super.key});

  @override
  State<AccessCodeContainer> createState() => _AccessCodeContainerState();
}

class _AccessCodeContainerState extends State<AccessCodeContainer> {
  bool _isLoading = false;
  String? existingAccessCode;

  void navigateToHomeNavigation() {
    Navigator.of(context).pushNamedAndRemoveUntil(
      StudentTeacherRoutes.myCourses,
      (Route<dynamic> route) => false,
    );
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
        : AccessCodeWidget(
            isLoading: _isLoading,
            onInstituteSelection: onInstituteSelection,
            existingAccessCode: existingAccessCode,
          );
  }
}
