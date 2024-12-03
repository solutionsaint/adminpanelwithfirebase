import 'package:flutter/material.dart';
import 'package:registration_app/containers/student/someone_face_recognition_container.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';

class SomeoneFaceRecognition extends StatelessWidget {
  const SomeoneFaceRecognition({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      topBarText: "Face Recognition",
      showInstituteName: false,
      child: SomeoneFaceRecognitionContainer(),
    );
  }
}
