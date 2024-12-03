import 'dart:convert';

class SuggestionModel {
  final String name;
  final String image;
  final bool isApproved;
  final bool isRejected;

  SuggestionModel({
    required this.name,
    required this.image,
    required this.isApproved,
    required this.isRejected,
  });

  factory SuggestionModel.fromJson(Map<String, dynamic> json) {
    return SuggestionModel(
      name: json["name"],
      image: json["image"],
      isApproved: json["isApproved"],
      isRejected: json["isRejected"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'isApproved': isApproved,
      'isRejected': isRejected,
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
