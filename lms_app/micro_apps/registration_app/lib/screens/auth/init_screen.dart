import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:registration_app/constants/enums/user_role_enum.dart';
import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/screens/auth/login_screen.dart';
import 'package:registration_app/screens/auth/role_type_selection_screen.dart';
import 'package:registration_app/screens/auth/welcome_screen.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/screens/admin/admin_app.dart';

class InitScreen extends StatefulWidget {
  const InitScreen({super.key});

  @override
  State<InitScreen> createState() => _InitScreenState();
}

class _InitScreenState extends State<InitScreen> {
  late VoidCallback authListener;

  @override
  void initState() {
    super.initState();
    authListener = () {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);

      if (!authProvider.isLoading) {
        if (authProvider.user == null && context.mounted) {
          authProvider.removeListener(authListener);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const WelcomeScreen(),
            ),
          );
          return;
        }

        if (authProvider.user != null &&
            authProvider.user!.emailVerified &&
            authProvider.loggedInStatus == true) {
          authProvider.removeListener(authListener);

          if (authProvider.currentUser!.role == UserRoleEnum.admin.roleName) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const AdminApp()),
            );
            return;
          } else {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const RoleTypeSelectionScreen(),
              ),
            );
            // if (authProvider.currentUser?.roleType == null ||
            //     authProvider.currentUser?.roleType == '') {
            //   Navigator.of(context).pushReplacement(
            //     MaterialPageRoute(
            //         builder: (context) => const RoleTypeSelectionScreen()),
            //   );
            //   return;
            // }
            // if (authProvider.currentUser!.isFaceRecognized! == false) {
            //   Navigator.of(context).pushReplacement(
            //     MaterialPageRoute(
            //       builder: (ctx) => const FaceRecognitionScreen(),
            //     ),
            //   );
            //   return;
            // }
            // if (authProvider.currentUser!.roleType ==
            //     UserRoleTypeEnum.student.roleName) {
            //   Navigator.of(context).pushReplacement(
            //     MaterialPageRoute(builder: (context) => const StudentApp()),
            //   );
            //   return;
            // }

            // if (authProvider.currentUser!.roleType ==
            //     UserRoleTypeEnum.teacher.roleName) {
            //   Navigator.of(context).pushReplacement(
            //     MaterialPageRoute(builder: (context) => const TeacherApp()),
            //   );
            //   return;
            // }
          }
        } else {
          authProvider.removeListener(authListener);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
        }
      }
    };

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.addListener(authListener);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // const Center(child: SVGLoader(image: Images.logo)),
            const SizedBox(height: 20),
            CircularProgressIndicator(color: ThemeColors.primary),
          ],
        ),
      ),
    );
  }
}
