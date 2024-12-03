import 'package:enquiry_app/core/services/enquiry/admin_enquiry_service.dart';
import 'package:enquiry_app/core/services/enquiry/messages_service.dart';
import 'package:enquiry_app/models/enquiry/enquiry_model.dart';
import 'package:enquiry_app/models/enquiry/message_model.dart';
import 'package:enquiry_app/providers/auth_provider.dart';
import 'package:enquiry_app/utils/error/show_snackbar.dart';
import 'package:enquiry_app/widgets/student_teacher/my_ticket_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTicketContainer extends StatefulWidget {
  const MyTicketContainer({
    super.key,
    required this.enquiry,
  });

  final EnquiryModel enquiry;

  @override
  State<MyTicketContainer> createState() => _MyTicketContainerState();
}

class _MyTicketContainerState extends State<MyTicketContainer> {
  MessagesService messagesService = MessagesService();
  List<MessageModel> messages = [];
  bool _isLoading = true;
  final AdminEnquiryService enquiryService = AdminEnquiryService();

  Future<void> fetchMessages() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      messages = await messagesService.fetchMessages(
        authProvider.selectedinstituteCode,
        authProvider.currentUser!.uid,
        widget.enquiry.enquiryId,
      );
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void onReOpenEnquiry() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      _isLoading = true;
    });
    final status = await enquiryService.reOpenEnquiry(
      widget.enquiry.enquiryId,
      authProvider.selectedinstituteCode,
    );
    setState(() {
      _isLoading = false;
    });

    if (status) {
      showSnackbar(context, 'Enquiry Reopened');
      Navigator.of(context).pop();
    } else {
      showSnackbar(context, 'Failed to Reopen Enquiry');
    }
  }

  void onResolveEnquiry() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    setState(() {
      _isLoading = true;
    });
    final status = await enquiryService.resolveEnquiry(
        widget.enquiry.enquiryId, authProvider.selectedinstituteCode);
    setState(() {
      _isLoading = false;
    });

    if (status) {
      showSnackbar(context, 'Enquiry resolved successfully');
      Navigator.of(context).pop();
    } else {
      showSnackbar(context, 'Failed to resolve enquiry');
    }
  }

  Future<bool> sendMessage(String message) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    try {
      final response = await messagesService.sendMessage(
        message,
        authProvider.selectedinstituteCode,
        authProvider.currentUser!.uid,
        "User",
        widget.enquiry.enquiryId,
      );
      if (response) {
        setState(() {
          messages.add(MessageModel(
            messageText: message,
            senderRole: "User",
          ));
        });
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return !_isLoading
        ? RefreshIndicator(
            onRefresh: fetchMessages,
            child: MyTicketWidget(
              enquiry: widget.enquiry,
              isLoading: _isLoading,
              onResolveEnquiry: onResolveEnquiry,
              onSendMessage: sendMessage,
              onReOpenEnquiry: onReOpenEnquiry,
              messages: messages,
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
