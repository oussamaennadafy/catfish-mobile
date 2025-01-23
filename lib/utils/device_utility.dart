import 'package:flutter/material.dart';

class DeviceUtility {
  static isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 768;
  }

  static isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 768 && MediaQuery.of(context).size.width < 1024;
  }

  static isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }
}
