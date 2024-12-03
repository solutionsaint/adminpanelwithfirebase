import 'package:attendance_app/core/services/admin/items_service.dart';
import 'package:attendance_app/models/courses/course_model.dart';
import 'package:attendance_app/providers/auth_provider.dart';
import 'package:attendance_app/widgets/admin/item_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ItemListContainer extends StatefulWidget {
  const ItemListContainer({super.key});

  @override
  State<ItemListContainer> createState() => ItemListContainerState();
}

class ItemListContainerState extends State<ItemListContainer> {
  List<CourseModel> myCourses = [];
  ItemsService itemsService =
      ItemsService(); // Variable to store fetched courses
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchCourses(); // Fetch courses when widget is initialized
  }

  Future<void> _fetchCourses() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    String instituteId = authProvider.currentUser!.institute[0];
    List<CourseModel> fetchedCourses =
        await itemsService.getCourses(instituteId);
    setState(() {
      isLoading = false;
      myCourses = fetchedCourses;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : ItemListWidget(myCourses: myCourses); // This will remain as is
  }
}
