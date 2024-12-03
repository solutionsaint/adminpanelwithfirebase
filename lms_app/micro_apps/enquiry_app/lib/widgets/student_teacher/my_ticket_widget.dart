import 'package:enquiry_app/themes/colors.dart';
import 'package:enquiry_app/widgets/common/icon_text_button.dart';
import 'package:enquiry_app/widgets/common/svg_lodder.dart';
import 'package:flutter/material.dart';

import 'package:enquiry_app/models/enquiry/message_model.dart';
import 'package:enquiry_app/widgets/common/full_screen_image_viewer.dart';
import 'package:enquiry_app/widgets/student_teacher/messages.dart';
import 'package:enquiry_app/models/enquiry/enquiry_model.dart';
import 'package:enquiry_app/resources/strings.dart';
import 'package:enquiry_app/themes/fonts.dart';
import 'package:enquiry_app/widgets/common/form_input.dart';
import 'package:enquiry_app/widgets/student_teacher/choose_file_button.dart';
import 'package:enquiry_app/widgets/student_teacher/enquiry_reception_title_card.dart';
import 'package:enquiry_app/resources/icons.dart' as icons;

class MyTicketWidget extends StatefulWidget {
  const MyTicketWidget({
    super.key,
    required this.enquiry,
    required this.onSendMessage,
    required this.messages,
    required this.isLoading,
    required this.onResolveEnquiry,
    required this.onReOpenEnquiry,
  });

  final EnquiryModel enquiry;
  final Future<bool> Function(String) onSendMessage;
  final List<MessageModel> messages;
  final bool isLoading;
  final void Function() onResolveEnquiry;
  final void Function() onReOpenEnquiry;

  @override
  State<MyTicketWidget> createState() => _MyTicketWidgetState();
}

class _MyTicketWidgetState extends State<MyTicketWidget> {
  final _formKey = GlobalKey<FormState>();
  String message = '';

  final ScrollController _scrollController = ScrollController();

  void onSendMessage() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final response = await widget.onSendMessage(message);
      if (response) {
        _formKey.currentState!.reset();
        _scrollToBottom(); // Scroll to bottom when a new message is sent
      }
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void didUpdateWidget(covariant MyTicketWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.messages.length > oldWidget.messages.length) {
      _scrollToBottom(); // Scroll to bottom when a new message is received
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Column(
      children: [
        EnquiryReceptionTitleCard(
          name: widget.enquiry.enquiryId,
          isTicket: true,
          priority: widget.enquiry.priority,
        ),
        Expanded(
          child: SizedBox(
            width: screenSize.width * 0.9,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        Strings.facingIssue,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        widget.enquiry.issue,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        Strings.subject,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Text(
                        widget.enquiry.subject,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Text(
                        Strings.describedIssue,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      children: [
                        Text(
                          widget.enquiry.description,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        Strings.view,
                        style: Theme.of(context).textTheme.bodyLargeTitleBrown,
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        width: 70,
                        child: ChooseFileButton(
                          onTap: () {
                            widget.enquiry.fileUrl != null
                                ? Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (ctx) => FullScreenImageViewer(
                                        imageUrl: widget.enquiry.fileUrl!,
                                      ),
                                    ),
                                  )
                                : null;
                          },
                          text: Strings.file,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        widget.enquiry.fileUrl != null ? '1 file' : 'no file',
                        style: Theme.of(context).textTheme.titleSmall,
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  if (widget.enquiry.isReOpen &&
                      widget.enquiry.status != "resolved")
                    SizedBox(
                      height: 50,
                      width: screenSize.width * 0.7,
                      child: IconTextButton(
                        text: Strings.resolve,
                        onPressed: widget.onResolveEnquiry,
                        color: ThemeColors.primary,
                        iconHorizontalPadding: 5,
                        svgIcon: icons.Icons.resolve,
                        iconColor: ThemeColors.white,
                        isLoading: widget.isLoading,
                      ),
                    ),
                  if (widget.enquiry.status == "resolved")
                    SizedBox(
                      height: 50,
                      width: screenSize.width * 0.7,
                      child: IconTextButton(
                        text: Strings.reOpen,
                        onPressed: widget.onReOpenEnquiry,
                        color: ThemeColors.primary,
                        iconHorizontalPadding: 5,
                        svgIcon: icons.Icons.resolve,
                        iconColor: ThemeColors.white,
                        isLoading: widget.isLoading,
                      ),
                    ),
                  const SizedBox(height: 30),
                  if (widget.messages.isNotEmpty)
                    Messages(
                      messages: widget.messages,
                    ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: screenSize.width * 0.9,
          child: Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: FormInput(
                    validator: (value) {
                      if (value!.trim().isEmpty) {
                        return "Type something";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      message = value!;
                    },
                    text: "",
                    hintText: "Type your message...",
                  ),
                ),
                IconButton(
                  icon: const SVGLoader(image: icons.Icons.send),
                  onPressed: onSendMessage,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
