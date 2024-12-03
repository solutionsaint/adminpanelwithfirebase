import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/core/services/firebase/firebase_auth_service.dart';
import 'package:registration_app/core/services/registration/registration_service.dart';
import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/routes/student_routes.dart';
import 'package:registration_app/utils/show_snackbar.dart';
import 'package:registration_app/widgets/student/kid_registration_widget.dart';

class KidRegistrationContainer extends StatefulWidget {
  const KidRegistrationContainer({
    super.key,
    required this.courses,
    required this.batchDay,
    required this.batchTime,
    required this.email,
    required this.userName,
    required this.mobileNumber,
  });

  final List<CourseModel> courses;
  final String batchDay;
  final String batchTime;
  final String email;
  final String userName;
  final String mobileNumber;

  @override
  State<KidRegistrationContainer> createState() =>
      _KidRegistrationContainerState();
}

class _KidRegistrationContainerState extends State<KidRegistrationContainer> {
  bool _isLoading = false;
  String uid = '';

  // Future<void> sendKidEmailVerification(String email) async {
  //   final HttpsCallable callable =
  //       FirebaseFunctions.instance.httpsCallable('sendKidEmailVerification');
  //   try {
  //     final result = await callable.call(<String, dynamic>{
  //       'email': email,
  //     });

  //     print('Email verification link sent: ${result.data}');
  //   } catch (e) {
  //     print('Error sending email verification: $e');
  //   }
  // }

  void registerKid(
    String userName,
    String userEmail,
    String phone,
    String userPassword,
  ) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final registrationService = RegistrationService();
    setState(() {
      _isLoading = true;
    });

    final isEmailAlreadyRegistered =
        await authProvider.isEmailAlreadyRegistered(userEmail);
    try {
      if (isEmailAlreadyRegistered) {
        showSnackbar(context, "Account already registered");
        setState(() {
          _isLoading = false;
        });
        return;
      }
      if (!isEmailAlreadyRegistered) {
        final HttpsCallable callable =
            FirebaseFunctions.instance.httpsCallable('createUser');
        final result = await callable.call(<String, dynamic>{
          'email': userEmail,
          'password': userPassword,
        });
        uid = result.data['uid'];
        await authProvider.createLMSUser(
          uid,
          userName,
          userEmail,
          'User',
          phone,
          ['Student'],
        );
        // final userCredential =
        //     await FirebaseAuthService().signInWithEmailAndPassword(
        //   userEmail,
        //   userPassword,
        // );
        // await userCredential.user!.sendEmailVerification();
      }

      final registrationIds = await registrationService.registerKid(
        courses: widget.courses,
        selectedBatchDay: widget.batchDay,
        selectedBatchTime: widget.batchTime,
        registeredBy: uid,
        userName: userName,
        mobileNumber: phone,
        registeredFor: 'Kid',
        email: userEmail,
        instituteId: authProvider.selectedinstituteCode,
      );

      if (registrationIds.isNotEmpty) {
        showSnackbar(context, 'Courses registered successfully');
        final List<CourseModel> courseData = authProvider.cart;
        authProvider.cart = [];
        Navigator.pushNamedAndRemoveUntil(
            context, StudentRoutes.kidEnrollment, (route) => false,
            arguments: {
              'registrationIds': registrationIds,
              'courses': courseData,
              'uid': uid,
            });
      } else {
        showSnackbar(context, 'Error registering courses for kid');
      }
    } catch (err) {
      print('Error details: $err');
      if (err is FirebaseFunctionsException) {
        print('Firebase Functions Error: ${err.code} - ${err.message}');
      }
      showSnackbar(
          context, 'Error registering courses for kid: ${err.toString()}');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return KidRegistrationWidget(
      mobileNumber: widget.mobileNumber,
      isLoading: _isLoading,
      registerKid: registerKid,
    );
  }
}
