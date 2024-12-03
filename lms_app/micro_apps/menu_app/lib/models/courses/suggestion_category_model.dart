class SuggestionCategoriesModel {
  final SuperCategory superCategory;

  SuggestionCategoriesModel({
    required this.superCategory,
  });

  factory SuggestionCategoriesModel.fromJson(Map<String, dynamic> json) {
    return SuggestionCategoriesModel(
      superCategory: SuperCategory.fromJson(json['superCategory']),
    );
  }

  Map<String, dynamic> toJson() => {
        'superCategory': superCategory.toJson(),
      };
}

class SuperCategory {
  final String name;
  final List<String> secondLevelCategories;

  SuperCategory({
    required this.name,
    required this.secondLevelCategories,
  });

  factory SuperCategory.fromJson(Map<String, dynamic> json) {
    return SuperCategory(
      name: json['name'],
      secondLevelCategories: List<String>.from(json['secondLevelCategories']),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'secondLevelCategories': secondLevelCategories,
      };
}
