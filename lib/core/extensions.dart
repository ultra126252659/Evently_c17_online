import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext {
  ThemeData theme() {
    return Theme.of(this);
  }

  Brightness brightness() {
    return Theme.of(this).colorScheme.brightness;
  }

  TextStyle bodyLarge() {
    return Theme.of(this).textTheme.bodyLarge!;
  }

  TextStyle displayMedium() {
    return Theme.of(this).textTheme.displayMedium!;
  }


  TextStyle displaySmall() {
    return Theme.of(this).textTheme.displaySmall!;
  }
}