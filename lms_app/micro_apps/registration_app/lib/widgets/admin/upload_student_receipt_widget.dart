import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:registration_app/models/registration/student_registration_model.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/utils/show_snackbar.dart';
import 'package:registration_app/widgets/admin/student_upload_card.dart';
import 'package:registration_app/widgets/common/icon_text_button.dart';
import 'package:registration_app/resources/icons.dart' as icons;

class UploadStudentReceiptWidget extends StatefulWidget {
  const UploadStudentReceiptWidget({
    super.key,
    required this.student,
    required this.onPressed,
    required this.isLoading,
  });

  final StudentRegistrationModel student;
  final void Function(
    String registrationId,
    File feeReceipt,
    File applicationReceipt,
  ) onPressed;
  final bool isLoading;

  @override
  State<UploadStudentReceiptWidget> createState() =>
      _UploadStudentReceiptWidgetState();
}

class _UploadStudentReceiptWidgetState
    extends State<UploadStudentReceiptWidget> {
  File? feeReceiptImage;
  File? applicationReceiptImage;

  void onPress() {
    if (feeReceiptImage != null && applicationReceiptImage != null) {
      widget.onPressed(widget.student.registrationId, feeReceiptImage!,
          applicationReceiptImage!);
    } else {
      showSnackbar(context, "Upload Files!");
    }
  }

  Future<void> _pickImage(bool isFeeReceipt) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        if (isFeeReceipt) {
          feeReceiptImage = File(pickedFile.path);
        } else {
          applicationReceiptImage = File(pickedFile.path);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 5),
      width: screenSize.width * 0.85,
      child: SingleChildScrollView(
        child: Column(
          children: [
            StudentUploadCard(
              student: widget.student,
              pickImage: _pickImage,
              feeReceiptImage: feeReceiptImage,
              applicationReceiptImage: applicationReceiptImage,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: screenSize.width * 0.7,
              height: 50,
              child: IconTextButton(
                iconHorizontalPadding: 7,
                radius: 20,
                text: Strings.confirm,
                onPressed: onPress,
                isLoading: widget.isLoading,
                color: ThemeColors.primary,
                buttonTextStyle: Theme.of(context).textTheme.bodyMedium,
                svgIcon: icons.Icons.cap,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
