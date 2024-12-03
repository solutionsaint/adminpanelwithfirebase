import 'package:flutter/material.dart';

import 'package:registration_app/containers/student/cart_container.dart';
import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/widgets/common/screen_layout.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenLayout(
      topBarText: Strings.cart,
      child: CartContainer(),
    );
  }
}
