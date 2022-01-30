import 'dart:io';

import 'package:flutter/foundation.dart';

class MediaDevice {
  static bool get isMobile => Platform.isIOS || Platform.isAndroid;
  static bool get isMobileDevice => !kIsWeb && isMobile;
  static bool get isMobileWeb => kIsWeb && isMobile;
  static bool get isMobileDeviceOrWeb => kIsWeb || isMobile;

  static bool get isDesktop =>
      Platform.isMacOS || Platform.isWindows || Platform.isLinux;
  static bool get isDesktopDevice => !kIsWeb && isDesktop;
  static bool get isDesktopWeb => kIsWeb && isDesktop;
  static bool get isDesktopDeviceOrWeb => kIsWeb || isDesktopDevice;
}
