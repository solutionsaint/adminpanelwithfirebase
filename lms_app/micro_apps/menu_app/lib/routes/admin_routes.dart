import 'package:flutter/material.dart';

import 'package:menu_app/screens/admin/add_item_screen.dart';
import 'package:menu_app/screens/admin/course_migration_screen.dart';
import 'package:menu_app/screens/admin/item_category_screen.dart';
import 'package:menu_app/screens/admin/item_list_screen.dart';
import 'package:menu_app/screens/admin/reception_enquiry_detail_screen.dart';
import 'package:menu_app/screens/admin/reception_enquiry_screen.dart';
import 'package:menu_app/screens/admin/resolved_enquiry_screen.dart';
import 'package:menu_app/screens/common/course_detail_screen.dart';

class AdminRoutes {
  AdminRoutes._();

  static const String itemList = '/item-list';
  static const String itemCategory = '/item-category';
  static const String addItem = '/add-item';
  static const String receptionEnquiry = '/reception-enquiry';
  static const String receptionEnquiryDetail = '/reception-enquiry-detail';
  static const String courseDetail = '/course-detail';
  static const String resolvedEnquiry = '/resolved-enquiry';
  static const String courseMigration = '/course-migration';

  static Map<String, WidgetBuilder> get buildAdminRoutes {
    return {
      itemList: (context) => const ItemListScreen(),
      addItem: (context) => const AddItemScreen(),
      receptionEnquiry: (context) => const ReceptionEnquiryScreen(),
      receptionEnquiryDetail: (context) => const ReceptionEnquiryDetailScreen(),
      courseDetail: (context) => const CourseDetailScreen(),
      itemCategory: (context) => const ItemCategoryScreen(),
      resolvedEnquiry: (context) => const ResolvedEnquiryScreen(),
      courseMigration: (context) => const CourseMigrationScreen(),
    };
  }

  static String get initialAdminRoute {
    return AdminRoutes.itemCategory;
  }
}
