import 'dart:io';

import 'package:attendance_app/core/services/face_recognition/face_recognition.dart';
import 'package:attendance_app/providers/auth_provider.dart';
import 'package:attendance_app/routes/attendance_app_routes.dart';
import 'package:attendance_app/utils/error/show_snackbar.dart';
import 'package:attendance_app/widgets/attendance/face_recognition_screen_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FaceRecignitionScreenContainer extends StatefulWidget {
  const FaceRecignitionScreenContainer({super.key});

  @override
  State<FaceRecignitionScreenContainer> createState() =>
      _FaceRecignitionScreenContainerState();
}

class _FaceRecignitionScreenContainerState
    extends State<FaceRecignitionScreenContainer> {
  bool _isLoading = false;

  Future<void> onSaveFaceRecognition(File images) async {
    setState(() {
      _isLoading = true;
    });
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final bool response = await verifyFace(
      images,
      authProvider.currentUser!.uid,
    );
    setState(() {
      _isLoading = false;
    });
    if (response) {
      showSnackbar(context, "Face recognition successful");
      Navigator.of(context)
          .pushReplacementNamed(AttendanceAppRoutes.accessCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FaceRecognitionScreenWidget(
      isLoading: _isLoading,
      onSaveFaceRecognition: onSaveFaceRecognition,
    );
  }
}
