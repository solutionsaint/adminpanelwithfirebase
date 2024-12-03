import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherRegistrationModel {
  final String courseName;
  final String courseId;
  final String registrationId;
  final String registeredBy;
  final String status;
  final String paymentStatus;
  final String imageUrl;
  final String registeredFor;
  final String userName;
  final Timestamp? registrationTime;

  TeacherRegistrationModel({
    required this.courseName,
    required this.courseId,
    required this.registrationId,
    required this.registeredBy,
    required this.status,
    required this.paymentStatus,
    required this.imageUrl,
    required this.registeredFor,
    required this.userName,
    this.registrationTime,
  });

  factory TeacherRegistrationModel.fromJson(Map<String, dynamic> json) {
    return TeacherRegistrationModel(
      courseName: json['courseName'] as String,
      courseId: json['courseId'] as String,
      registrationId: json['registrationId'] as String,
      registeredBy: json['registeredBy'] as String,
      status: json['status'] as String,
      paymentStatus: json['paymentStatus'] as String,
      imageUrl: json['imageUrl'] as String,
      registeredFor: json['registeredFor'] as String,
      userName: json['userName'] as String,
      registrationTime: json['registrationTime'] != null
          ? (json['registrationTime'] as Timestamp)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'courseName': courseName,
      'courseId': courseId,
      'registrationId': registrationId,
      'registeredBy': registeredBy,
      'status': status,
      'paymentStatus': paymentStatus,
      'imageUrl': imageUrl,
      'registeredFor': registeredFor,
      'userName': userName,
      'registrationTime': registrationTime,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeacherRegistrationModel &&
          runtimeType == other.runtimeType &&
          courseName == other.courseName &&
          courseId == other.courseId &&
          registrationId == other.registrationId &&
          registeredBy == other.registeredBy &&
          status == other.status &&
          paymentStatus == other.paymentStatus &&
          imageUrl == other.imageUrl &&
          registeredFor == other.registeredFor &&
          userName == other.userName;

  @override
  int get hashCode => Object.hash(
        courseName,
        courseId,
        registrationId,
        registeredBy,
        status,
        paymentStatus,
        imageUrl,
        registeredFor,
      );

  TeacherRegistrationModel copyWith({
    String? courseName,
    String? courseId,
    String? registrationId,
    String? registeredBy,
    String? status,
    String? paymentStatus,
    String? imageUrl,
    String? registeredFor,
    String? userName,
  }) {
    return TeacherRegistrationModel(
      courseName: courseName ?? this.courseName,
      courseId: courseId ?? this.courseId,
      registrationId: registrationId ?? this.registrationId,
      registeredBy: registeredBy ?? this.registeredBy,
      status: status ?? this.status,
      paymentStatus: paymentStatus ?? this.paymentStatus,
      imageUrl: imageUrl ?? this.imageUrl,
      registeredFor: registeredFor ?? this.registeredFor,
      userName: userName ?? this.userName,
    );
  }
}
