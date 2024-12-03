import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/widgets/common/icon_text_button.dart';
import 'package:flutter/material.dart';

import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';

class EnquiryReceptionTitleCard extends StatelessWidget {
  const EnquiryReceptionTitleCard({
    super.key,
    this.isTicket = false,
    required this.name,
    this.priority,
  });

  final String name;
  final String? priority;
  final bool isTicket;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    Widget content = Row(
      children: [
        const SizedBox(width: 10),
        Text(
          'Hello !! $name',
          style: Theme.of(context).textTheme.bodyMediumTitleBrown,
        ),
      ],
    );
    if (isTicket) {
      content = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 10),
              Text(
                Strings.ticketNo,
                style: Theme.of(context).textTheme.bodyMediumTitleBrown,
              ),
              Text(
                name,
                style: Theme.of(context).textTheme.displaySmallPrimarySemiBold,
              )
            ],
          ),
          SizedBox(
            height: 40,
            width: screenSize.width * 0.3,
            child: IconTextButton(
              text: priority!,
              onPressed: () {},
              color: ThemeColors.cardColor,
              iconHorizontalPadding: 0,
              buttonTextStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          )
        ],
      );
    }
    return Container(
      height: 100,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ThemeColors.cardBorderColor,
            width: 0.2,
          ),
          top: BorderSide(
            color: ThemeColors.cardBorderColor,
            width: 0.2,
          ),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            spreadRadius: 0,
            color: ThemeColors.black.withOpacity(0.1),
            offset: const Offset(0, 2),
          )
        ],
        color: ThemeColors.white,
      ),
      child: content,
    );
  }
}
