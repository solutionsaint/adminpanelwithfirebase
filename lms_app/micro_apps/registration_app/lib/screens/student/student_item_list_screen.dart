import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:registration_app/containers/student/student_item_list_container.dart';
import 'package:registration_app/providers/auth_provider.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/routes/student_routes.dart';
import 'package:registration_app/utils/show_snackbar.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';
import 'package:registration_app/widgets/common/svg_lodder.dart';
import 'package:registration_app/resources/icons.dart' as icons;

class StudentItemListScreen extends StatelessWidget {
  const StudentItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      topBarText: Strings.itemList,
      showBackButton: false,
      icon: const SVGLoader(
        image: icons.Icons.cartIconSvg,
      ),
      child: const StudentItemListContainer(),
      onIconTap: () {
        final authProvider = Provider.of<AuthProvider>(context, listen: false);
        if (authProvider.cart.isNotEmpty) {
          Navigator.of(context).pushNamed(StudentRoutes.cart);
          return;
        }
        showSnackbar(context, 'Cart is empty');
      },
    );
  }
}
