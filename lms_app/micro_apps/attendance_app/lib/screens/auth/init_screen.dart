import 'package:attendance_app/constants/enums/user_role_enum.dart';
import 'package:attendance_app/providers/auth_provider.dart';
import 'package:attendance_app/screens/admin/admin_app.dart';
import 'package:attendance_app/screens/attendance/app.dart';
import 'package:attendance_app/screens/auth/login_screen.dart';
import 'package:attendance_app/screens/common/welcome_screen.dart';
import 'package:attendance_app/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) =>
                  authProvider.currentUser!.role == UserRoleEnum.admin.roleName
                      ? const AdminApp()
                      : const StudentTeacherAttencanceApp(),
            ),
          );
          return;
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
            const SizedBox(height: 20),
            CircularProgressIndicator(color: ThemeColors.primary),
          ],
        ),
      ),
    );
  }
}
