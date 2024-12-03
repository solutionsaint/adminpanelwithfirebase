import 'dart:convert';
import 'dart:io';

class SearchModel {
  final String name;
  final File? file;
  final String? url;
  final bool valid;

  SearchModel({
    required this.name,
    this.file,
    this.url,
    required this.valid,
  });

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      name: json['name'],
      file: json['file'] != null ? File(json['file']) : null,
      url: json['url'],
      valid: json['valid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'file': file?.path,
      'url': url,
      'valid': valid,
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
