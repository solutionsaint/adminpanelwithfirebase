import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:location_app/themes/colors.dart';
import 'package:location_app/widgets/common/success_card.dart';

void showSuccessModal(
  BuildContext oldContext,
  String text,
  void Function()? onPress,
  List<String>? content,
) {
  showDialog(
    context: oldContext,
    barrierDismissible: false,
    builder: (context) {
      return Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: ThemeColors.white.withOpacity(0.3),
              ),
            ),
          ),
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: SuccessCard(
              content: content,
              text: text,
              onPress: () {
                Navigator.of(context).pop();
                onPress != null ? onPress() : null;
              },
            ),
          ),
        ],
      );
    },
  );
}
