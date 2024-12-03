import 'dart:convert';

class CategoryModel {
  final String categoryName;
  final String categoryTitle;
  final String iconUrl;

  CategoryModel({
    required this.categoryName,
    required this.categoryTitle,
    required this.iconUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      categoryName: json['categoryName'],
      categoryTitle: json['categoryTitle'],
      iconUrl: json['iconUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoryName': categoryName,
      'categoryTitle': categoryTitle,
      'iconUrl': iconUrl,
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
