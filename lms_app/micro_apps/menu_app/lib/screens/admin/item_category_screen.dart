import 'package:flutter/material.dart';
import 'package:menu_app/containers/admin/item_category_container.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/widgets/menu/menu_layout.dart';

class ItemCategoryScreen extends StatelessWidget {
  const ItemCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MenuLayout(
      showBackButton: false,
      topBarText: Strings.itemCategory,
      child: ItemCategoryContainer(),
    );
  }
}
