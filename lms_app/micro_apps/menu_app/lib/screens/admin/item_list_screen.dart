import 'package:flutter/material.dart';
import 'package:menu_app/containers/admin/item_list_container.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/widgets/menu/menu_layout.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Extract arguments from the route
    final Map<String, dynamic> args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final String subCategory = args['category'] as String;
    final bool showBack = args['showBack'] as bool;

    return MenuLayout(
      topBarText: Strings.itemList,
      showBackButton: showBack,
      child: ItemListContainer(subCategory: subCategory),
    );
  }
}
