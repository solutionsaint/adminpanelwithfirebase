import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:menu_app/models/category/category_model.dart';
import 'package:menu_app/utils/logger/logger.dart';
import 'package:menu_app/core/services/firebase/firebase_storage_service.dart';

class CategoryService {
  CategoryService._privateConstructor();
  final log = CustomLogger.getLogger('Category Service');
  final FirebaseStorageService _storageService = FirebaseStorageService();

  // Static instance of the class
  static final CategoryService _instance =
      CategoryService._privateConstructor();

  // Factory constructor to return the static instance
  factory CategoryService() {
    return _instance;
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Add a category and return the updated list of categories
  Future<List<CategoryModel>> addCategory(
    String categoryName,
    String categoryTitle,
    File icon,
    String accessId,
  ) async {
    try {
      // Upload icon to Firebase Storage and get the download URL
      final String iconUrl = await _storageService.uploadFile(
        icon,
        'categories/$accessId/$categoryName/icon',
        icon.path.split('/').last,
      );

      // Create category model
      final CategoryModel category = CategoryModel(
        categoryName: categoryName,
        categoryTitle: categoryTitle,
        iconUrl: iconUrl,
      );

      // Add category to Firestore with categoryName as the document ID
      await _firestore
          .collection('institutes')
          .doc(accessId)
          .collection('categories')
          .doc()
          .set(category.toJson());

      log.i('Category $categoryName added successfully.');

      // Fetch the updated list of categories from Firestore
      final QuerySnapshot snapshot = await _firestore
          .collection('institutes')
          .doc(accessId)
          .collection('categories')
          .get();
      final List<CategoryModel> categories = snapshot.docs
          .map((doc) =>
              CategoryModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      return categories;
    } catch (e) {
      log.e('Error adding category: $e');
      return [];
    }
  }

  Future<List<CategoryModel>> getCategories(String accessId) async {
    try {
      // Fetch all documents from the 'categories' collection
      final QuerySnapshot snapshot = await _firestore
          .collection('institutes')
          .doc(accessId)
          .collection('categories')
          .get();

      // Convert the documents to a list of CategoryModel instances
      final List<CategoryModel> categories = snapshot.docs
          .map((doc) =>
              CategoryModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();

      log.i('Fetched ${categories.length} categories.');
      return categories;
    } catch (e) {
      log.e('Error fetching categories: $e');
      return [];
    }
  }
}
