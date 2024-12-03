import 'package:flutter/material.dart';

import 'package:registration_app/themes/colors.dart';
import 'package:registration_app/widgets/common/svg_lodder.dart';
import 'package:registration_app/resources/icons.dart' as icons;

class StatusProgressIndicator extends StatelessWidget {
  final bool isApproved;
  final bool isReady;

  const StatusProgressIndicator({
    super.key,
    required this.isApproved,
    required this.isReady,
  });

  @override
  Widget build(BuildContext context) {
    double progressValue = 0.0;
    double iconOpacity = 0.3;

    if (isApproved && isReady) {
      progressValue = 1.0;
      iconOpacity = 1.0;
    } else if (isApproved || isReady) {
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
