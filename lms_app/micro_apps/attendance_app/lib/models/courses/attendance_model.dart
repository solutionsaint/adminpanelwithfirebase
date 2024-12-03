import 'dart:convert';

class AttendanceModel {
  final bool status;
  AttendanceModel({
    required this.status,
  });

  factory AttendanceModel.fromJson(Map<String, dynamic> json) {
    return AttendanceModel(status: json['status']);
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
    };
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
