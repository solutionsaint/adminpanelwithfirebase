import 'package:flutter/material.dart';

import 'package:location_app/constants/enums/button_size.dart';

EdgeInsetsGeometry getElevatedButtonPadding(ButtonSize? buttonSize) {
  switch (buttonSize) {
    case ButtonSize.small:
      return const EdgeInsets.symmetric(vertical: 10, horizontal: 20);
    case ButtonSize.large:
      return const EdgeInsets.symmetric(vertical: 16, horizontal: 20);
    case ButtonSize.extraSmall:
      return const EdgeInsets.symmetric(vertical: 8, horizontal: 15);
    default:
      return const EdgeInsets.symmetric(vertical: 10, horizontal: 20);
  }
}
