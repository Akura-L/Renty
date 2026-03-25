import 'package:flutter/material.dart';

class Responsive {
  static double screenPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 120.0;
    if (width > 800) return 80.0;
    return 16.0;
  }

  static int dynamicGridCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 800) return 3;
    if (width > 600) return 2;
    return 1;
  }
}
