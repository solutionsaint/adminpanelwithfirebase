import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:menu_app/models/category/category_model.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/routes/admin_routes.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';
import 'package:menu_app/widgets/admin/category_item_card.dart';
import 'package:menu_app/widgets/common/custom_dashed_input.dart';
import 'package:menu_app/widgets/common/form_input.dart';
import 'package:menu_app/widgets/common/icon_text_button.dart';

class ItemCategoryWidget extends StatefulWidget {
  const ItemCategoryWidget({
    super.key,
    required this.onAddCategory,
    required this.categories,
    required this.isLoading,
  });

  final void Function(String categoryName, String categoryTitle, File icon)
      onAddCategory;
  final List<CategoryModel> categories;
  final bool isLoading;
  @override
  _ItemCategoryWidgetState createState() => _ItemCategoryWidgetState();
}

class _ItemCategoryWidgetState extends State<ItemCategoryWidget> {
  final formKey = GlobalKey<FormState>();
  String categoryName = '';
  String categoryTitle = '';
  File? _image;
  String? imageError;

  final ImagePicker _picker = ImagePicker();

  Future<void> onMediaSelected(
      ImageSource imageSource, Function(void Function()) setDialogState) async {
    final pickedFile = await _picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setDialogState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              title: const Text(Strings.addCategory),
              content: Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    FormInput(
                      text: "Category Name",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Invalid Category Name";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        categoryName = value!;
                      },
                    ),
                    const SizedBox(height: 10),
                    FormInput(
                      text: "Category Title",
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Invalid Category Title";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        categoryTitle = value!;
                      },
                    ),
                    const SizedBox(height: 10),
                    _image == null
                        ? CustomDashedInput(
                            text: "Category Icon",
                            onTap: () {
                              onMediaSelected(
                                  ImageSource.gallery, setDialogState);
                            },
                            radius: 50,
                          )
                        : Row(
                            children: [
                              const SizedBox(width: 10),
                              Text(
                                'Icon uploaded',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(color: Colors.brown),
                              ),
                            ],
                          ),
                    if (imageError != null)
                      Column(
                        children: [
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                "Please upload an icon",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall!
                                    .copyWith(
                                      color: ThemeColors.errorColor,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the modal
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();

                      if (_image != null) {
                        widget.onAddCategory(
                            categoryName, categoryTitle, _image!);
                        Navigator.of(context).pop();
                      } else {
                        setDialogState(() {
                          imageError = "Upload an icon";
                        });
                      }
                    }
                  },
                  child: const Text('Add'),
                ),
              ],
            );
          },
        );
      },
    ).then((_) {
      setState(() {
        _image = null;
        imageError = null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    void navigateToItemList(String subCategory) {
      Navigator.of(context).pushNamed(
        AdminRoutes.itemList,
        arguments: {
          'category': subCategory,
          'showBack': true,
        },
      );
    }

    if (widget.isLoading) {
      return Center(
        child: Text(
          "Adding Category....",
          style: Theme.of(context).textTheme.bodyMediumTitleBrown,
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: screenSize.width * 0.9,
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              width: 200,
              height: 40,
              margin: const EdgeInsets.symmetric(vertical: 7),
              child: IconTextButton(
                text: Strings.addCategory,
                onPressed: () {
                  showAddCategoryDialog(context);
                },
                color: ThemeColors.primary,
                iconHorizontalPadding: 7,
              ),
            ),
          ),
          Expanded(
            child: widget.categories.isNotEmpty
                ? ListView.builder(
                    padding: const EdgeInsets.only(top: 0),
                    itemCount: widget.categories.length,
                    itemBuilder: (context, index) {
                      final category = widget.categories[index];
                      return CategoryItemCard(
                        icon: category.iconUrl,
                        title: category.categoryName,
                        onTap: () => navigateToItemList(category.categoryName),
                      );
                    },
                  )
                : Text(
                    "No Categories Found",
                    style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                  ),
          ),
        ],
      ),
    );
  }
}
