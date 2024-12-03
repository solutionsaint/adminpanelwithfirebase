import 'package:flutter/material.dart';

import 'package:registration_app/models/enquiry/message_model.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';

class Messages extends StatelessWidget {
  const Messages({
    super.key,
    required this.messages,
  });

  final List<MessageModel> messages;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              "Chat",
              style: Theme.of(context).textTheme.bodyMediumTitleBrown,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: ThemeColors.primary,
              width: 1.5,
            ),
          ),
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (ctx, index) {
              final MessageModel message = messages[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: message.senderRole == "User"
                      ? MainAxisAlignment.start
                      : MainAxisAlignment.end,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.75,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: ThemeColors.primary,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        message.messageText,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 14,
                            ),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: messages.length,
          ),
        ),
      ],
    );
  }
}
