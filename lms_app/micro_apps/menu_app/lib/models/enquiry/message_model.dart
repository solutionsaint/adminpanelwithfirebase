import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderRole;
  final String messageText;
  final Timestamp? timestamp;

  MessageModel({
    required this.senderRole,
    required this.messageText,
    this.timestamp,
  });

  // Convert a MessageModel instance to a Map for Firestore storage
  Map<String, dynamic> toJson() {
    return {
      'senderRole': senderRole,
      'messageText': messageText,
      'timestamp': timestamp,
    };
  }

  // Create a MessageModel instance from a Firestore document
  factory MessageModel.fromJson(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MessageModel(
      senderRole: data['senderRole'],
      messageText: data['messageText'],
      timestamp: data['timestamp'] ?? '',
    );
  }
}
