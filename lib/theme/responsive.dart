import 'package:flutter/material.dart';

/// Simple width-based breakpoints so the UI can adapt as the person
/// resizes the Chrome tab — narrow like a phone, medium like a tablet,
/// or wide like a desktop browser window.
class Responsive {
  static const double mobileMax = 600;
  static const double tabletMax = 1000;

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < mobileMax;

  static bool isTablet(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    return w >= mobileMax && w < tabletMax;
  }

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= tabletMax;

  /// Width of the auth form card: nearly full width on a phone-size
  /// tab, capped and centered on a wider window.
  static double authCardMaxWidth(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < mobileMax) return w; // full-bleed on narrow tabs
    if (w < tabletMax) return 440;
    return 460;
  }

  static double authCardPadding(BuildContext context) =>
      isMobile(context) ? 20 : 28;

  static double authHorizontalPadding(BuildContext context) =>
      isMobile(context) ? 16 : 32;

  static double logoFontSize(BuildContext context) =>
      isMobile(context) ? 34 : 44;

  static double heroHeight(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w < mobileMax) return 200;
    if (w < tabletMax) return 280;
    return 360;
  }

  static double posterTileWidth(BuildContext context) =>
      isMobile(context) ? 78 : (isTablet(context) ? 100 : 120);

  static double posterTileHeight(BuildContext context) =>
      isMobile(context) ? 112 : (isTablet(context) ? 144 : 170);
}
