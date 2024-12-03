import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:registration_app/models/registration/teacher_registration_model.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/widgets/admin/action_card.dart';

class TeacherListWidget extends StatelessWidget {
  const TeacherListWidget({
    super.key,
    required this.isLoading,
    required this.registrationList,
    required this.onApproveTeacher,
    required this.onRejectTeacher,
  });

  final bool isLoading;
  final List<TeacherRegistrationModel> registrationList;
  final void Function(String) onApproveTeacher;
  final void Function(String) onRejectTeacher;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (registrationList.isEmpty) {
      return Center(
        child: Text('No teachers registered yet',
            style: TextStyle(
              fontSize: 20,
              color: ThemeColors.primary,
            )),
      );
    }

    // Date formatting utility
    String formatDate(Timestamp? timestamp) {
      if (timestamp == null) {
        return 'N/A';
      }
      DateTime dateTime = timestamp.toDate();
      return DateFormat('MMM d, h:mm a').format(dateTime);
    }

    return Container(
      width: screenSize.width * 0.9,
      margin: const EdgeInsets.only(top: 10),
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: registrationList
            .map((teacher) => ActionCard(
                  imageUrl: teacher.imageUrl,
                  registeredTime: formatDate(teacher.registrationTime),
                  name: teacher.userName,
                  courseName: teacher.courseName,
                  paymentDone: teacher.paymentStatus == 'Paid',
                  onAccept: () => onApproveTeacher(teacher.registrationId),
                  onReject: () => onRejectTeacher(teacher.registrationId),
                ))
            .toList(),
      ),
    );
  }
}
