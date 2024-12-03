import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:registration_app/models/enquiry/message_model.dart';
import 'package:registration_app/utils/logger/logger.dart';

class MessagesService {
  MessagesService._privateConstructor();
  final log = CustomLogger.getLogger('Appointments Service');

  // Static instance of the class
  static final MessagesService _instance =
      MessagesService._privateConstructor();

  // Factory constructor to return the static instance
  factory MessagesService() {
    return _instance;
  }

  final _firestore = FirebaseFirestore.instance;
  Future<bool> sendMessage(
    String message,
    String accessId,
    String senderRole,
    String enquiryId,
  ) async {
    try {
      // Create a new message
      final newMessage = MessageModel(
        senderRole: senderRole,
        messageText: message,
        timestamp: Timestamp.now(),
      );

      // Add the message to the 'messages' collection within the specific enquiry document
      await _firestore
          .collection('institutes')
          .doc(accessId)
          .collection('enquiries')
          .doc(enquiryId) // Correctly reference the enquiry document
          .collection('messages')
          .add(newMessage.toJson());
      return true;
    } catch (e) {
      log.e('Error sending message: $e');
      return false;
    }
  }

  Future<List<MessageModel>> fetchMessages(
    String accessId,
    String enquiryId,
  ) async {
    try {
      // Fetch the messages collection from Firestore
      QuerySnapshot enquirySnapshot = await _firestore
          .collection('institutes')
          .doc(accessId)
          .collection('enquiries')
          .where(enquiryId)
          .get();

      if (enquirySnapshot.docChanges.isNotEmpty) {
        QuerySnapshot querySnapshot = await _firestore
            .collection('institutes')
            .doc(accessId)
            .collection('enquiries')
            .doc(enquiryId)
            .collection('messages')
            .orderBy(
              'timestamp',
              descending: false,
            ) // Optional: Order by timestamp
            .get();

        // Convert each document to MessageModel
        return querySnapshot.docs.map((doc) {
          return MessageModel.fromJson(doc);
        }).toList();
      }
      return [];
    } catch (e) {
      print('Error fetching messages: $e');
      return [];
    }
  }
}
