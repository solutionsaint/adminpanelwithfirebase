import 'package:flutter/material.dart';
import 'package:attendance_app/models/enquiry/enquiry_model.dart';

import 'package:attendance_app/resources/strings.dart';
import 'package:attendance_app/themes/colors.dart';
import 'package:attendance_app/themes/fonts.dart';

class EnquiryCard extends StatelessWidget {
  const EnquiryCard({
    super.key,
    required this.enquiry,
    required this.onTap,
  });

  final EnquiryModel enquiry;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
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
                enquiry.fileUrl ?? Strings.url,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  enquiry.enquiryId,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMediumTitleBrownSemiBold
                      .copyWith(
                        fontSize: 14,
                      ),
                ),
                // Text(
                //   "Student",
                //   style: Theme.of(context).textTheme.titleSmallTitleBrown,
                // ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      Strings.ticketNo,
                      style: Theme.of(context).textTheme.titleSmallTitleBrown,
                    ),
                    SizedBox(
                      width: 120,
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        enquiry.enquiryId,
                        style: Theme.of(context)
                            .textTheme
                            .displaySmallPrimarySemiBold,
                      ),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
