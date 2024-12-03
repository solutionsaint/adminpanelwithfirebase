import 'package:flutter/material.dart';

import 'package:attendance_app/containers/attendance/face_recognition_screen_container.dart';
import 'package:attendance_app/widgets/attendance/attendance_layout.dart';

class FaceRecognitionScreen extends StatelessWidget {
  const FaceRecognitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AttendanceLayout(
      showInstituteName: false,
      topBarText: "Face Recognition",
      showBackButton: false,
      child: FaceRecignitionScreenContainer(),
    );
  }
}
