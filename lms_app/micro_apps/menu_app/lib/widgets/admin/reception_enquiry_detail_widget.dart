import 'package:flutter/material.dart';

import 'package:menu_app/models/enquiry/enquiry_model.dart';
import 'package:menu_app/models/enquiry/message_model.dart';
import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';
import 'package:menu_app/widgets/admin/messages.dart';
import 'package:menu_app/widgets/common/choose_file_button.dart';
import 'package:menu_app/widgets/common/enquiry_reception_title_card.dart';
import 'package:menu_app/widgets/common/form_input.dart';
import 'package:menu_app/widgets/common/full_screen_image_viewer.dart';
import 'package:menu_app/resources/icons.dart' as icons;
import 'package:menu_app/widgets/common/icon_text_button.dart';
import 'package:menu_app/widgets/common/svg_lodder.dart';

class ReceptionEnquiryDetailWidget extends StatefulWidget {
  const ReceptionEnquiryDetailWidget({
    super.key,
    required this.enquiry,
    required this.onSendMessage,
    required this.messages,
    required this.isLoading,
    required this.onResolveEnquiry,
  });

  final EnquiryModel enquiry;
  final Future<bool> Function(String) onSendMessage;
  final void Function() onResolveEnquiry;
  final List<MessageModel> messages;
  final bool isLoading;

  @override
  State<ReceptionEnquiryDetailWidget> createState() =>
      _ReceptionEnquiryDetailWidgetState();
}

class _ReceptionEnquiryDetailWidgetState
    extends State<ReceptionEnquiryDetailWidget> {
  final _formKey = GlobalKey<FormState>();
  String message = '';

  final ScrollController _scrollController = ScrollController();

  void onSendMessage() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final response = await widget.onSendMessage(message);
      if (response) {
        _formKey.currentState!.reset();
        _scrollToBottom();
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
  void didUpdateWidget(covariant ReceptionEnquiryDetailWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
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
                  if (widget.messages.isNotEmpty)
                    Messages(
                      messages: widget.messages,
                    ),
                  if (!widget.enquiry.isReOpen &&
                      widget.enquiry.status == 'created')
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
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: screenSize.width * 0.9,
          child: Form(
            key: _formKey, // Assign the form key here
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
