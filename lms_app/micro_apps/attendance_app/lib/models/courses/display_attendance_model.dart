import 'dart:convert';

class DisplayAttendanceModel {
  final bool status;
  final String date;
  DisplayAttendanceModel({
    required this.status,
    required this.date,
  });

  factory DisplayAttendanceModel.fromJson(Map<String, dynamic> json) {
    return DisplayAttendanceModel(status: json['status'], date: json['date']);
  }

  Map<String, dynamic> toJson() {
    return {'status': status, 'date': date};
  }

  @override
  String toString() {
    return json.encode(toJson());
  }
}
