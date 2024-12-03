import 'package:flutter/material.dart';
import 'package:registration_app/containers/student/kid_registration_container.dart';
import 'package:registration_app/resources/images.dart';
import 'package:registration_app/themes/fonts.dart';

class KidRegistrationScreen extends StatelessWidget {
  const KidRegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final courses = args['courses'];
    final batchDay = args['batchDay'];
    final batchTime = args['batchTime'];
    final email = args['email'];
    final userName = args['userName'];
    final mobileNumber = args['mobileNumber'];

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Images.signupBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(top: 70, bottom: 160),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Register Someone you know!',
                            maxLines: 2,
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(fontSize: 20.0),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Enter details',
                        style: Theme.of(context)
                            .textTheme
                            .displayMediumSemiBold
                            .copyWith(fontSize: 15.0),
                      ),
                    ],
                  ),
                  KidRegistrationContainer(
                    courses: courses,
                    batchDay: batchDay,
                    batchTime: batchTime,
                    email: email,
                    userName: userName,
                    mobileNumber: mobileNumber,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
