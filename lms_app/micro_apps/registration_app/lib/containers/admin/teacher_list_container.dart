import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/core/services/registration/registration_service.dart';
import 'package:registration_app/models/registration/teacher_registration_model.dart';
import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/utils/widgets/show_success_modal.dart';

import 'package:registration_app/widgets/admin/teacher_list_widget.dart';

class TeacherListContainer extends StatefulWidget {
  const TeacherListContainer({super.key});

  @override
  State<TeacherListContainer> createState() => _TeacherListContainerState();
}

class _TeacherListContainerState extends State<TeacherListContainer> {
  bool _isLoading = false;
  List<TeacherRegistrationModel> _registrationList = [];

  Future<void> fetchTeacherRegistrationList() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await RegistrationService()
          .getTeacherRegistrationList(authProvider.currentUser!.institute[0]);
      setState(() {
        _registrationList = response;
      });
    } catch (e) {
      print('Error fetching teacher registration list: $e');
    }
    setState(() {
      _isLoading = false;
    });
  }

  void onApproveTeacher(String registrationId) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      final bool response = await RegistrationService().onAcceptTeacher(
          registrationId, authProvider.currentUser!.institute[0]);

      if (response) {
        showSuccessModal(
          context,
          Strings.successfully,
          () {
            setState(() {
              _registrationList = _registrationList
                  .where((teacher) => teacher.registrationId != registrationId)
                  .toList();
            });
          },
          [registrationId],
        );
      }
    } catch (e) {
      print('Error approving student $e');
    }
  }

  void onRejectTeacher(String registrationId) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      final bool response = await RegistrationService().onRejectTeacher(
          registrationId, authProvider.currentUser!.institute[0]);

      if (response) {
        setState(() {
          _registrationList = _registrationList
              .where((teacher) => teacher.registrationId != registrationId)
              .toList();
        });
      }
    } catch (e) {
      print('Error approving student $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchTeacherRegistrationList();
  }

  @override
  Widget build(BuildContext context) {
    return TeacherListWidget(
      isLoading: _isLoading,
      registrationList: _registrationList,
      onApproveTeacher: onApproveTeacher,
      onRejectTeacher: onRejectTeacher,
    );
  }
}
