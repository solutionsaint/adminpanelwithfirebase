import 'package:flutter/material.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';
import 'package:registration_app/widgets/admin/action_button.dart';
import 'package:registration_app/resources/icons.dart' as icons;

class ActionCard extends StatelessWidget {
  const ActionCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.courseName,
    required this.paymentDone,
    required this.onAccept,
    required this.onReject,
    required this.registeredTime,
  });

  final String imageUrl;
  final String name;
  final String courseName;
  final bool paymentDone;
  final void Function() onAccept;
  final void Function() onReject;
  final String registeredTime;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: ThemeColors.white,
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
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 10,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0),
            child: Image.network(
              imageUrl,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '${Strings.name} : ',
                    style: Theme.of(context)
                        .textTheme
                        .displayMediumTitleBrownSemiBold,
                  ),
                  Text(
                    name,
                    style: Theme.of(context)
                        .textTheme
                        .displayMediumPrimarySemiBold,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '${Strings.course1} : ',
                    style: Theme.of(context)
                        .textTheme
                        .displayMediumTitleBrownSemiBold,
                  ),
                  Text(
                    courseName,
                    style: Theme.of(context)
                        .textTheme
                        .displayMediumPrimarySemiBold,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'At : ',
                    style: Theme.of(context)
                        .textTheme
                        .displayMediumTitleBrownSemiBold,
                  ),
                  Text(
                    registeredTime,
                    style: Theme.of(context)
                        .textTheme
                        .displayMediumPrimarySemiBold,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '${Strings.payment} : ',
                    style: Theme.of(context)
                        .textTheme
                        .displayMediumTitleBrownSemiBold,
                  ),
                  Text(
                    paymentDone ? Strings.done : Strings.pending,
                    style: Theme.of(context)
                        .textTheme
                        .displayMediumPrimarySemiBold
                        .copyWith(
                          color: paymentDone
                              ? ThemeColors.primary
                              : ThemeColors.titleBrown,
                        ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ActionButton(
                text: "Accept",
                icon: icons.Icons.accept,
                onTap: onAccept,
              ),
              ActionButton(
                text: "Reject",
                icon: icons.Icons.reject,
                onTap: onReject,
              ),
            ],
          )
        ],
      ),
    );
  }
}
