import 'package:flutter/material.dart';

import 'package:menu_app/resources/strings.dart';
import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/themes/fonts.dart';

class BatchOfferedCard extends StatefulWidget {
  final List<String> selectedDays;
  final List<String> selectedTime;
  final ValueChanged<List<String>> onSelectedDaysChanged;
  final ValueChanged<List<String>> onSelectedTimeChanged;

  const BatchOfferedCard({
    super.key,
    required this.selectedDays,
    required this.selectedTime,
    required this.onSelectedDaysChanged,
    required this.onSelectedTimeChanged,
  });

  @override
  BatchOfferedCardState createState() => BatchOfferedCardState();
}

class BatchOfferedCardState extends State<BatchOfferedCard> {
  final List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final List<String> _customTimes = [
    'Early Morning',
    'Late Morning',
    'Early Afternoon',
    'Late Afternoon',
    'Early Evening',
    'Late Evening',
    'Night'
  ];

  List<String> customDays = [];
  List<String> customTimes = [];
  String? customTime;

  String customDaysErr = '';
  void _showCustomDayPickerDialog(BuildContext context) {
    String localCustomDaysErr = '';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              title: const Text('Select Days'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ..._daysOfWeek.map((day) {
                      return CheckboxListTile(
                        title: Text(day),
                        value: customDays.contains(day),
                        onChanged: (bool? isChecked) {
                          setDialogState(() {
                            if (isChecked == true) {
                              customDays.add(day);
                            } else {
                              customDays.remove(day);
                            }
                            localCustomDaysErr = '';
                          });
                        },
                      );
                    }),
                    if (localCustomDaysErr.isNotEmpty)
                      Text(
                        localCustomDaysErr,
                        style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                      )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      widget.selectedDays.remove("Custom");
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (customDays.isEmpty) {
                      setDialogState(() {
                        localCustomDaysErr = 'Please select at least one day.';
                      });
                      return;
                    }

                    final sortedSelectedDays = List<String>.from(customDays)
                      ..sort();
                    final combinedDays = sortedSelectedDays.join("+");

                    bool isCombinationExists =
                        widget.selectedDays.any((existingCombination) {
                      final existingDays = existingCombination.split("+")
                        ..sort();
                      return existingDays.join("+") == combinedDays;
                    });

                    if (!isCombinationExists) {
                      setState(() {
                        widget.selectedDays.add(combinedDays);
                        customDays.clear();
                        Navigator.pop(context);
                      });
                    } else {
                      setDialogState(() {
                        localCustomDaysErr = 'Already added';
                      });
                    }
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showCustomTimePickerDialog(BuildContext context) {
    String localCustomTimeErr = '';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setDialogState) {
            return AlertDialog(
              title: const Text('Select Times'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ..._customTimes.map((time) {
                      return CheckboxListTile(
                        title: Text(
                          time,
                          style:
                              Theme.of(context).textTheme.bodyMediumTitleBrown,
                        ),
                        value: customTimes.contains(time),
                        onChanged: (bool? isChecked) {
                          setDialogState(() {
                            if (isChecked == true) {
                              customTimes.add(time);
                            } else {
                              customTimes.remove(time);
                            }
                            localCustomTimeErr = '';
                          });
                        },
                      );
                    }),
                    if (localCustomTimeErr.isNotEmpty)
                      Text(
                        localCustomTimeErr,
                        style: Theme.of(context).textTheme.bodyMediumTitleBrown,
                      )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      widget.selectedTime.remove("Custom");
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (customTimes.isEmpty) {
                      setDialogState(() {
                        localCustomTimeErr = 'At least select one';
                      });
                      return;
                    }
                    setState(() {
                      widget.selectedTime.addAll(customTimes);
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _handleDayChange(String day, bool isSelected) {
    final newSelectedDays = List<String>.from(widget.selectedDays);
    if (isSelected) {
      newSelectedDays.add(day);
    } else {
      newSelectedDays.remove(day);
    }
    widget.onSelectedDaysChanged(newSelectedDays);
  }

  void _handleTimeChange(String time, bool isSelected) {
    final newSelectedTime = List<String>.from(widget.selectedTime);
    if (isSelected) {
      newSelectedTime.add(time);
    } else {
      newSelectedTime.remove(time);
    }
    widget.onSelectedTimeChanged(newSelectedTime);
  }

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
          Wrap(
            runSpacing: 20,
            children: [
              _CustomCheckbox(
                text: 'Weekend',
                value: widget.selectedDays.contains('Weekend'),
                onChanged: (bool? newValue) {
                  _handleDayChange('Weekend', newValue!);
                },
              ),
              const SizedBox(width: 20),
              _CustomCheckbox(
                text: 'Weekday',
                value: widget.selectedDays.contains('Weekday'),
                onChanged: (bool? newValue) {
                  _handleDayChange('Weekday', newValue!);
                },
              ),
              ...widget.selectedDays.map((customDay) {
                if (customDay == 'Weekend' || customDay == 'Weekday') {
                  return const SizedBox();
                }
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: _CustomCheckbox(
                    text: customDay,
                    value: widget.selectedDays.contains(customDay),
                    onChanged: (bool? newValue) {
                      _handleDayChange(customDay, newValue!);
                    },
                  ),
                );
              }),
              _CustomCheckbox(
                isAdd: true,
                text: 'Custom',
                value: widget.selectedDays.contains('Custom'),
                onChanged: (bool? newValue) {},
                onTap: () => _showCustomDayPickerDialog(context),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            Strings.time,
            style: Theme.of(context).textTheme.bodyMediumTitleBrownSemiBold,
          ),
          const SizedBox(height: 10),
          Wrap(
            runSpacing: 20,
            children: [
              //should automatically added here
              _CustomCheckbox(
                text: 'Morning',
                value: widget.selectedTime.contains('Morning'),
                onChanged: (bool? newValue) {
                  _handleTimeChange('Morning', newValue!);
                },
              ),
              const SizedBox(width: 10),
              _CustomCheckbox(
                text: 'Evening',
                value: widget.selectedTime.contains('Evening'),
                onChanged: (bool? newValue) {
                  _handleTimeChange('Evening', newValue!);
                },
              ),

              ...customTimes.map((customTime) {
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: _CustomCheckbox(
                    text: customTime,
                    value: widget.selectedTime.contains(customTime),
                    onChanged: (bool? newValue) {
                      _handleTimeChange(customTime, newValue!);
                    },
                  ),
                );
              }),
              _CustomCheckbox(
                isAdd: true,
                text: 'Custom',
                value: widget.selectedTime.contains('Custom'),
                onChanged: (bool? newValue) {},
                onTap: () => _showCustomTimePickerDialog(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CustomCheckbox extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool?> onChanged;
  final bool isAdd;
  final void Function()? onTap;

  const _CustomCheckbox({
    required this.text,
    required this.value,
    required this.onChanged,
    this.isAdd = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLong = text.split('+').length > 2;
    return Container(
      width: isLong ? null : 140,
      height: 47,
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
      padding: const EdgeInsets.only(left: 12),
      child: Row(
        mainAxisAlignment:
            isAdd ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              maxLines: 2,
              text,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontSize: 10),
            ),
          ),
          if (!isAdd)
            Transform.scale(
              scale: 1,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                activeColor: ThemeColors.titleBrown,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
          if (isAdd)
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: InkWell(
                onTap: onTap,
                child: Icon(
                  Icons.add,
                  color: ThemeColors.titleBrown,
                ),
              ),
            )
        ],
      ),
    );
  }
}
