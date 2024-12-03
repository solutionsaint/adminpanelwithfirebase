import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/widgets/common/batch_offered_card.dart';
import 'package:registration_app/widgets/common/form_input.dart';
import 'package:registration_app/widgets/common/icon_text_button.dart';
import 'package:registration_app/resources/icons.dart' as icons;

class TeacherRegisterWidget extends StatefulWidget {
  const TeacherRegisterWidget({
    super.key,
    required this.course,
    required this.selectedBatchDay,
    required this.selectedBatchTime,
    required this.onRegisterCourseForTeacher,
    required this.isLoading,
  });

  final CourseModel course;
  final String selectedBatchDay;
  final String selectedBatchTime;
  final Function(String, String) onRegisterCourseForTeacher;
  final bool isLoading;

  @override
  State<TeacherRegisterWidget> createState() => _TeacherRegisterWidgetState();
}

class _TeacherRegisterWidgetState extends State<TeacherRegisterWidget> {
  String batchDay = '';
  String batchTime = '';

  void onPressed() {
    widget.onRegisterCourseForTeacher(batchDay, batchTime);
  }

  @override
  void initState() {
    super.initState();
    batchDay = widget.selectedBatchDay;
    batchTime = widget.selectedBatchTime;
  }

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

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final formKey = GlobalKey<FormState>();
    String email = authProvider.currentUser?.email ?? '';
    String userName = authProvider.currentUser?.name ?? '';
    String mobileNumber = authProvider.currentUser?.phone ?? '';
    final Size screenSize = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Container(
        width: screenSize.width * 0.9,
        margin: const EdgeInsets.only(top: 30),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              FormInput(
                text: Strings.email,
                initialValue: email,
                readOnly: true,
              ),
              const SizedBox(height: 20),
              FormInput(
                text: Strings.userName,
                initialValue: userName,
                readOnly: true,
              ),
              const SizedBox(height: 20),
              FormInput(
                text: Strings.mobileNumber,
                initialValue: mobileNumber,
                readOnly: true,
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
                  onPressed: onPressed,
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
