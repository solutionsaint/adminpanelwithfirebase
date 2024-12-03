import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/core/services/registration/registration_service.dart';
import 'package:registration_app/models/registration/student_registration_model.dart';
import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/routes/admin_routes.dart';
import 'package:registration_app/utils/widgets/show_success_modal.dart';

import 'package:registration_app/widgets/admin/upload_student_receipt_widget.dart';

class UploadStudentReceiptContainer extends StatefulWidget {
  const UploadStudentReceiptContainer({
    super.key,
    required this.student,
  });

  final StudentRegistrationModel student;

  @override
  State<UploadStudentReceiptContainer> createState() =>
      _UploadStudentReceiptContainerState();
}

class _UploadStudentReceiptContainerState
    extends State<UploadStudentReceiptContainer> {
  bool _isLoading = false;

  Future<void> onApproveRegistration(
    String registrationId,
    File feeReceipt,
    File applicationReceipt,
  ) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await RegistrationService().onAcceptStudent(
          registrationId,
          feeReceipt,
          applicationReceipt,
          authProvider.currentUser!.institute[0]);
      if (response) {
        showSuccessModal(
          context,
          Strings.acknowledgment,
          () {
            Navigator.of(context).pushNamedAndRemoveUntil(
              AdminRoutes.studentList,
              ModalRoute.withName(AdminRoutes.registrationList),
            );
            // Navigator.of(context).pushReplacementNamed(
            //   AdminRoutes.studentList,
            // );
          },
          [registrationId],
        );
      }
    } catch (e) {
      print('Error approving student $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return UploadStudentReceiptWidget(
      student: widget.student,
      onPressed: onApproveRegistration,
      isLoading: _isLoading,
    );
  }
}
