import 'package:flutter/material.dart';

import 'package:enquiry_app/resources/strings.dart';
import 'package:enquiry_app/themes/colors.dart';
import 'package:enquiry_app/themes/fonts.dart';

class TicketCard extends StatelessWidget {
  const TicketCard({
    super.key,
    required this.ticketNo,
    required this.subject,
    required this.onTap,
    this.imageUrl,
  });

  final String ticketNo;
  final String subject;
  final void Function() onTap;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        decoration: BoxDecoration(
          color: ThemeColors.cardColor,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: ThemeColors.cardBorderColor,
            width: 0.3,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(
                imageUrl ?? Strings.url,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      Strings.ticketNo,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmallTitleBrown
                          .copyWith(
                            fontSize: 14,
                          ),
                    ),
                    SizedBox(
                      width: 120,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        ticketNo,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmallPrimarySemiBold,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      '${Strings.subject} : ',
                      style: Theme.of(context)
                          .textTheme
                          .displayMediumTitleBrownSemiBold,
                    ),
                    Text(
                      subject,
                      style: Theme.of(context)
                          .textTheme
                          .displayMediumPrimarySemiBold,
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
