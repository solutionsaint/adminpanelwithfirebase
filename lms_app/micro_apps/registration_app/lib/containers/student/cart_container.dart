import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:registration_app/models/registration/course_model.dart';
import 'package:registration_app/providers/auth_provider.dart';

import 'package:registration_app/widgets/student/cart_widget.dart';

class CartContainer extends StatefulWidget {
  const CartContainer({super.key});

  @override
  State<CartContainer> createState() => _CartContainerState();
}

class _CartContainerState extends State<CartContainer> {
  List<CourseModel>? courses;

  @override
  void initState() {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    super.initState();
    courses = authProvider.cart;
  }

  void onRemoveFromCart(String courseId) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    authProvider.removeFromCart(courseId);

    setState(() {
      courses = authProvider.cart;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CartWidget(
      courses: courses!,
      onRemoveFromCat: onRemoveFromCart,
    );
  }
}
