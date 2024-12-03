import 'package:flutter/material.dart';

import 'package:registration_app/containers/admin/upload_student_receipt_container.dart';
import 'package:registration_app/models/registration/student_registration_model.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';

class UploadStudentReceiptScreen extends StatelessWidget {
  const UploadStudentReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    StudentRegistrationModel student =
        ModalRoute.of(context)?.settings.arguments as StudentRegistrationModel;
    return ScreenLayout(
      topBarText: Strings.student,
      child: UploadStudentReceiptContainer(
        student: student,
      ),
    );
  }
}
