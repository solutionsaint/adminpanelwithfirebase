import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:registration_app/core/services/face_recognition/face_recignition_firebase_service.dart';
import 'package:registration_app/core/services/face_recognition/face_recognition.dart';
import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/routes/student_routes.dart';
import 'package:registration_app/widgets/student/face_recognition_screen_widget.dart';

class FaceRecignitionScreenContainer extends StatefulWidget {
  const FaceRecignitionScreenContainer({
    super.key,
    required this.kidUid,
  });
  final String? kidUid;
  @override
  State<FaceRecignitionScreenContainer> createState() =>
      _FaceRecignitionScreenContainerState();
}

class _FaceRecignitionScreenContainerState
    extends State<FaceRecignitionScreenContainer> {
  bool _isLoading = false;
  FaceRecognitionFirebaseService faceRecignitionFirebaseService =
      FaceRecognitionFirebaseService();

  Future<void> onSaveFaceRecognition(List<File?> images) async {
    setState(() {
      _isLoading = true;
    });
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final bool response = await saveFaceRecognition(
      images,
      widget.kidUid ?? authProvider.currentUser!.uid,
    );
    if (response) {
      await faceRecignitionFirebaseService
          .saveFaceRecognitionFlag(authProvider.currentUser!.uid);
      authProvider.saveFaceRecognitionFlag();
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pushNamedAndRemoveUntil(
      StudentRoutes.itemList,
      (Route<dynamic> route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FaceRecognitionScreenWidget(
      isLoading: _isLoading,
      onSaveFaceRecognition: onSaveFaceRecognition,
    );
  }
}
