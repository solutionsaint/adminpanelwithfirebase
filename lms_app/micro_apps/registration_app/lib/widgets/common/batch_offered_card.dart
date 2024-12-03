import 'package:flutter/material.dart';

import 'package:registration_app/resources/strings.dart';
import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/themes/fonts.dart';

class BatchOfferedCard extends StatefulWidget {
  const BatchOfferedCard({
    super.key,
    required this.selectedBatchDay,
    required this.selectedBatchTime,
    required this.onBatchDayChanged,
    required this.onBatchTimeChanged,
  });

  final String selectedBatchDay;
  final String selectedBatchTime;
  final ValueChanged<String> onBatchDayChanged;
  final ValueChanged<String> onBatchTimeChanged;

  @override
  BatchOfferedCardState createState() => BatchOfferedCardState();
}

class BatchOfferedCardState extends State<BatchOfferedCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: ThemeColors.cardColor,
        border: Border.all(
          color: ThemeColors.cardBorderColor,
          width: 0.3,
        ),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 5,
            spreadRadius: 0,
            color: ThemeColors.black.withOpacity(0.1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Strings.days,
            style: Theme.of(context).textTheme.bodyMediumTitleBrownSemiBold,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _CustomRadioButton(
                text: 'Weekend',
                value: 'Weekend',
                groupValue: widget.selectedBatchDay,
                onChanged: (value) {
                  widget.onBatchDayChanged(value!);
                },
              ),
              const SizedBox(width: 20),
              _CustomRadioButton(
                text: 'Weekday',
                value: 'Weekday',
                groupValue: widget.selectedBatchDay,
                onChanged: (value) {
                  widget.onBatchDayChanged(value!);
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            Strings.time,
            style: Theme.of(context).textTheme.bodyMediumTitleBrownSemiBold,
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _CustomRadioButton(
                text: 'Morning',
                value: 'Morning',
                groupValue: widget.selectedBatchTime,
                onChanged: (value) {
                  widget.onBatchTimeChanged(value!);
                },
              ),
              const SizedBox(width: 20),
              _CustomRadioButton(
                text: 'Evening',
                value: 'Evening',
                groupValue: widget.selectedBatchTime,
                onChanged: (value) {
                  widget.onBatchTimeChanged(value!);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CustomRadioButton extends StatelessWidget {
  final String text;
  final String value;
  final String groupValue;
  final ValueChanged<String?> onChanged;

  const _CustomRadioButton({
    required this.text,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 135,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: ThemeColors.white,
        boxShadow: [
          BoxShadow(
            offset: const Offset(1, 2.5),
            blurRadius: 9,
            spreadRadius: 0,
            color: ThemeColors.black.withOpacity(0.1),
          ),
        ],
      ),
      padding: const EdgeInsets.only(left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          Radio<String>(
            value: value,
            groupValue: groupValue,
            onChanged: onChanged,
            activeColor: ThemeColors.titleBrown,
          ),
        ],
      ),
    );
  }
}
