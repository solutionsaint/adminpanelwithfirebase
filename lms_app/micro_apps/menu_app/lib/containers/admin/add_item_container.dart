import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:menu_app/core/services/courses/course_service.dart';
import 'package:menu_app/models/courses/suggestion_category_model.dart';
import 'package:menu_app/providers/auth_provider.dart';
import 'package:menu_app/routes/admin_routes.dart';
import 'package:menu_app/utils/show_snackbar.dart';

import 'package:menu_app/widgets/admin/add_item_widget.dart';
import 'package:provider/provider.dart';

class AddItemContainer extends StatefulWidget {
  const AddItemContainer({super.key, required this.subCategory});

  final String subCategory;

  @override
  State<AddItemContainer> createState() => _AddItemContainerState();
}

class _AddItemContainerState extends State<AddItemContainer> {
  bool _isLoading = false;
  bool _initialLoading = true;
  List<String> superCategories = [];
  List<String> categories = [];
  List<SuggestionCategoriesModel> suggestionHierarchy = [];
  final CourseService _courseService = CourseService();

  @override
  void initState() {
    super.initState();
    getSuggestions();
  }

  Future<void> getSuggestions() async {
    final service = CourseService();
    final response = await service.getSuggestionCategories();
    setState(() {
      superCategories = response.map((cat) => cat.superCategory.name).toList();
      categories = response
          .expand((category) => category.superCategory.secondLevelCategories)
          .toList();
      suggestionHierarchy = response;
      _initialLoading = false;
    });
  }

  Future<void> addItem(Map<String, dynamic> formData, List<File> image) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      _isLoading = true;
    });
    final courseId = await _courseService.addItem(
      formData,
      image,
      authProvider.currentUser!.institute[0],
      widget.subCategory,
    );
    setState(() {
      _isLoading = false;
    });
    if (courseId != null) {
      showSnackbar(context, 'Item added successfully');
      Navigator.of(context).pushNamedAndRemoveUntil(
        AdminRoutes.itemList,
        (Route<dynamic> route) => false,
        arguments: {
          'category': widget.subCategory,
          'showBack': false,
        },
      );
    } else {
      showSnackbar(context, 'Failed to add item');
    }
  }

  Future<bool> onAddSuggestion(String name, File image) async {
    final response = await _courseService.addSuggestion(name, image);
    if (response) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_initialLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return AddItemWidget(
      isLoading: _isLoading,
      addItem: addItem,
      subCategory: widget.subCategory,
      onAddSuggestion: onAddSuggestion,
      superCategories: superCategories,
      categories: categories,
      suggestionHierarchy: suggestionHierarchy,
    );
  }
}
