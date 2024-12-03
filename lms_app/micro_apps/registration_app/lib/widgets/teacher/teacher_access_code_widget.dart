import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/resources/images.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/screens/auth/welcome_screen.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';
import 'package:registration_app/utils/show_snackbar.dart';
import 'package:registration_app/widgets/common/custom_elevated_button.dart';
import 'package:registration_app/widgets/common/form_input.dart';

class TeacherAccessCodeWidget extends StatefulWidget {
  final bool isLoading;
  final String? existingAccessCode;
  final Function(String accessCode) onInstituteSelection;

  const TeacherAccessCodeWidget({
    super.key,
    required this.onInstituteSelection,
    required this.isLoading,
    this.existingAccessCode,
  });

  @override
  State<TeacherAccessCodeWidget> createState() => _AccessCodeWidgetState();
}

class _AccessCodeWidgetState extends State<TeacherAccessCodeWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accessCodeController = TextEditingController();
  String _instituteCode = '';

  @override
  void initState() {
    super.initState();
    if (widget.existingAccessCode != null) {
      _accessCodeController.text = widget.existingAccessCode!;
    }
  }

  void onSubmit() {
    _formKey.currentState?.save();
    widget.onInstituteSelection(_instituteCode);
  }

  @override
  void dispose() {
    _accessCodeController.dispose();
    super.dispose();
  }

  void logout(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final response = await authProvider.signOut();
    if (response) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const WelcomeScreen(),
        ),
        (Route<dynamic> route) => false,
      );
    } else {
      showSnackbar(context, Strings.errorLoggingOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: screenSize.height,
          width: screenSize.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.optionBackgroundNew),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: screenSize.width * 0.92,
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeColors.primaryShadow,
                      blurRadius: 10.0,
                      spreadRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10.0),
                      Text(
                        "Access Code",
                        textAlign: TextAlign.center,
                        style:
                            Theme.of(context).textTheme.bodyLargeTitleBrownBold,
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        children: [
                          const SizedBox(width: 10.0),
                          Text(
                            "Access Code : ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMediumTitleBrown,
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: screenSize.width * 0.8,
                        child: Focus(
                          onFocusChange: (hasFocus) {
                            if (hasFocus && widget.existingAccessCode != null) {
                              _accessCodeController.text =
                                  widget.existingAccessCode!;
                            }
                          },
                          child: FormInput(
                            text: "Enter Access Code",
                            controller: _accessCodeController,
                            onSaved: (value) => {_instituteCode = value!},
                          ),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        height: 50,
                        width: screenSize.width * 0.4,
                        child: CustomElevatedButton(
                          text: "Confirm",
                          onPressed: onSubmit,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () => logout(context),
                            child: SizedBox(
                              child: Row(
                                children: [
                                  Text(
                                    "Logout",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmallTitleBrown
                                        .copyWith(
                                            decoration:
                                                TextDecoration.underline),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.logout_outlined,
                                    size: 14,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
