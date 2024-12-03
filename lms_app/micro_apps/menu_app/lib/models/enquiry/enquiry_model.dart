class EnquiryModel {
  final String enquiryId;
  final String userId;
  final String issue;
  final String subject;
  final String description;
  final String priority;
  final String type;
  final String status;
  final String? fileUrl;
  final bool isReOpen;

  EnquiryModel({
    required this.enquiryId,
    required this.userId,
    required this.issue,
    required this.subject,
    required this.description,
    required this.priority,
    required this.type,
    required this.status,
    required this.isReOpen,
    this.fileUrl,
  });

  // Convert an Enquiry object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'enquiryId': enquiryId,
      'userId': userId,
      'issue': issue,
      'subject': subject,
      'description': description,
      'priority': priority,
      'type': type,
      'status': status,
      'fileUrl': fileUrl,
      'isReOpen': isReOpen,
    };
  }

  // Create an Enquiry object from a JSON map
  factory EnquiryModel.fromJson(Map<String, dynamic> json) {
    return EnquiryModel(
      enquiryId: json['enquiryId'] as String,
      userId: json['userId'] as String,
      issue: json['issue'] as String,
      subject: json['subject'] as String,
      description: json['description'] as String,
      priority: json['priority'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      fileUrl: json['fileUrl'] as String?,
      isReOpen: json['isReOpen'] != null ? json['isReOpen'] as bool : false,
    );
  }
}
