import 'package:cloud_firestore/cloud_firestore.dart';

class StudentRegistrationModel {
  final String courseName;
  final String courseId;
  final String registrationId;
  final String registeredBy;
  final String status;
  final String paymentStatus;
  final String imageUrl;
  final String registeredFor;
  final String batchDay;
  final String batchTime;
  final String email;
  final String userName;
  final String mobileNumber;
  final Timestamp? registrationTime;

  StudentRegistrationModel({
    required this.courseName,
    required this.courseId,
    required this.registrationId,
    required this.registeredBy,
    required this.status,
    required this.paymentStatus,
    required this.imageUrl,
    required this.registeredFor,
    required this.batchDay,
    required this.batchTime,
    required this.email,
    required this.userName,
    required this.mobileNumber,
    this.registrationTime,
  });

  factory StudentRegistrationModel.fromJson(Map<String, dynamic> json) {
    return StudentRegistrationModel(
      courseName: json['courseName'] as String,
      courseId: json['courseId'] as String,
      registrationId: json['registrationId'] as String,
      registeredBy: json['registeredBy'] as String,
      status: json['status'] as String,
      paymentStatus: json['paymentStatus'] as String,
      imageUrl: json['imageUrl'] as String,
      registeredFor: json['registeredFor'] as String,
      batchDay: json['batchDay'] as String,
      batchTime: json['batchTime'] as String,
      email: json['email'] as String,
      userName: json['userName'] as String,
      mobileNumber: json['mobileNumber'] as String,
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
      'batchDay': batchDay,
      'batchTime': batchTime,
      'email': email,
      'userName': userName,
      'mobileNumber': mobileNumber,
      'registrationTime': registrationTime,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentRegistrationModel &&
          runtimeType == other.runtimeType &&
          courseName == other.courseName &&
          courseId == other.courseId &&
          registrationId == other.registrationId &&
          registeredBy == other.registeredBy &&
          status == other.status &&
          paymentStatus == other.paymentStatus &&
          imageUrl == other.imageUrl &&
          registeredFor == other.registeredFor &&
          batchDay == other.batchDay &&
          batchTime == other.batchTime &&
          email == other.email &&
          userName == other.userName &&
          mobileNumber == other.mobileNumber;

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
        batchDay,
        batchTime,
        email,
        userName,
        mobileNumber,
      );
}
