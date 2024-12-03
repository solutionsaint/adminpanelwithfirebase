import 'package:flutter/material.dart';

import 'package:menu_app/themes/colors.dart';
import 'package:menu_app/widgets/common/svg_lodder.dart';
import 'package:menu_app/resources/icons.dart' as icons;

class StatusProgressIndicator extends StatelessWidget {
  final bool isAcknowledged;
  final bool isResolved;

  const StatusProgressIndicator({
    super.key,
    required this.isAcknowledged,
    required this.isResolved,
  });

  @override
  Widget build(BuildContext context) {
    double progressValue = 0.0;
    double iconOpacity = 0.3;

    if (isAcknowledged && isResolved) {
      progressValue = 1.0;
      iconOpacity = 1.0;
    } else if (isAcknowledged || isResolved) {
      progressValue = 0.5;
      iconOpacity = 0.6;
    }

    return SizedBox(
      width: 100,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: CircularProgressIndicator(
              value: progressValue,
              color: ThemeColors.primary,
              backgroundColor: ThemeColors.primary.withOpacity(0.2),
              strokeWidth: 6,
            ),
          ),
          Opacity(
            opacity: iconOpacity,
            child: const SVGLoader(image: icons.Icons.successIcon),
          ),
        ],
      ),
    );
  }
}
