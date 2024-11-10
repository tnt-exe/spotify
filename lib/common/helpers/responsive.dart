import 'package:flutter/material.dart';

extension Responsive on BuildContext {
  bool get isPhoneScreen {
    return MediaQuery.sizeOf(this).width <= 480;
  }

  bool get isTabletScreen {
    return MediaQuery.sizeOf(this).width <= 1024;
  }

  bool get isDesktopScreen {
    return MediaQuery.sizeOf(this).width > 1024;
  }

  double get screenWidth {
    return MediaQuery.sizeOf(this).width;
  }

  double get responsiveScreenWidth {
    return MediaQuery.sizeOf(this).width / 2;
  }
}
