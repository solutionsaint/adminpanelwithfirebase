import 'package:flutter/material.dart';
import 'package:registration_app/containers/student/face_recognition_screen_container.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';

class FaceRecognitionScreen extends StatelessWidget {
  const FaceRecognitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String? uid = ModalRoute.of(context)!.settings.arguments as String?;
    return ScreenLayout(
      topBarText: "Face Recognition",
      child: FaceRecignitionScreenContainer(
        kidUid: uid,
      ),
    );
  }
}
