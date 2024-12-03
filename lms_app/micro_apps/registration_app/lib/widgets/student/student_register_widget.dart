import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/providers/auth_provider.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/widgets/common/form_input.dart';
import 'package:registration_app/widgets/common/icon_text_button.dart';
import 'package:registration_app/widgets/common/radio_button.dart';
import 'package:registration_app/resources/icons.dart' as icons;

class StudentRegisterWidget extends StatefulWidget {
  final bool isLoading;
  final Function(
    String,
    String,
    String,
  ) registerStudent;

  const StudentRegisterWidget({
    super.key,
    required this.registerStudent,
    required this.isLoading,
  });

  @override
  State<StudentRegisterWidget> createState() => _StudentRegisterWidgetState();
}

class _StudentRegisterWidgetState extends State<StudentRegisterWidget> {
  final formKey = GlobalKey<FormState>();

  String? selectedOption = 'Self';
  String batchDay = 'Weekend';
  String batchTime = 'Morning';

  void _handleRegister() {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      widget.registerStudent(
        selectedOption!,
        batchDay,
        batchTime,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    void onBatchDayChanged(String value) {
      setState(() {
        batchDay = value;
      });
    }

    void onBatchTimeChanged(String value) {
      setState(() {
        batchTime = value;
      });
    }

    return SingleChildScrollView(
      child: Container(
        width: screenSize.width * 0.9,
        margin: const EdgeInsets.only(top: 30),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              FormInput(
                text: "",
                hintText: authProvider.currentUser!.email,
                readOnly: true,
              ),
              const SizedBox(height: 20),
              FormInput(
                text: "",
                hintText: authProvider.currentUser!.name,
                readOnly: true,
              ),
              const SizedBox(height: 20),
              FormInput(
                text: "",
                hintText: authProvider.currentUser!.phone,
                readOnly: true,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  RadioButton(
                    selectedOption: selectedOption!,
                    onChange: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                    value: "Self",
                  ),
                  const SizedBox(width: 10),
                  RadioButton(
                    selectedOption: selectedOption!,
                    onChange: (value) {
                      setState(() {
                        selectedOption = value;
                      });
                    },
                    value: "For Someone else",
                  )
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: screenSize.width * 0.7,
                height: 50,
                child: IconTextButton(
                  isLoading: widget.isLoading,
                  iconHorizontalPadding: 7,
                  radius: 20,
                  text: Strings.register,
                  onPressed: _handleRegister,
                  color: ThemeColors.primary,
                  buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
                  svgIcon: icons.Icons.bookIcon,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
