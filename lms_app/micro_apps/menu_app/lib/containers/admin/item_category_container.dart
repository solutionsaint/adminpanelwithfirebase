import 'dart:io';

import 'package:flutter/material.dart';
import 'package:menu_app/core/services/category/category_service.dart';
import 'package:menu_app/core/services/courses/course_service.dart';
import 'package:menu_app/models/category/category_model.dart';
import 'package:menu_app/providers/auth_provider.dart';
import 'package:menu_app/routes/admin_routes.dart';
import 'package:menu_app/widgets/admin/item_category_widget.dart';
import 'package:provider/provider.dart';

class ItemCategoryContainer extends StatefulWidget {
  const ItemCategoryContainer({super.key});

  @override
  State<ItemCategoryContainer> createState() => _ItemCategoryContainerState();
}

class _ItemCategoryContainerState extends State<ItemCategoryContainer> {
  CourseService courseService = CourseService();
  CategoryService categoryService = CategoryService();
  List<CategoryModel> categories = [];
  bool isLoaded = false;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    checkCategory();
    fetchCategories();
  }

  void fetchCategories() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      setState(() {
        isLoading = true;
      });
      categories = await categoryService
          .getCategories(authProvider.currentUser!.institute[0]);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  void checkCategory() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String? selectedCategory = await courseService
        .hasSelectedCategory(authProvider.currentUser!.institute[0]);
    if (selectedCategory != null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        AdminRoutes.itemList,
        (Route<dynamic> route) => false,
        arguments: {
          'category': selectedCategory,
          'showBack': false,
        },
      );
    } else {
      setState(() {
        isLoaded = true;
      });
    }
  }

  void onAddCategory(
    String categoryName,
    String categoryTitle,
    File icon,
  ) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    final List<CategoryModel> updatedCategories =
        await categoryService.addCategory(
      categoryName,
      categoryTitle,
      icon,
      authProvider.currentUser!.institute[0],
    );
    if (updatedCategories.isNotEmpty) {
      setState(() {
        categories = updatedCategories;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? ItemCategoryWidget(
            categories: categories,
            onAddCategory: onAddCategory,
            isLoading: isLoading,
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
