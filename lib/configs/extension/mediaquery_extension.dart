import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  double get mediaQueryHeight => MediaQuery.sizeOf(this).height;
  double get mediaQueryWidth => MediaQuery.sizeOf(this).width;
}
