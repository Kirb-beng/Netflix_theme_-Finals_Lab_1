import 'package:flutter/material.dart';

/// Centralized Netflix-inspired color palette and text styles.
/// Keeping these in one place is what makes the Login, Sign-Up,
/// and Home screens look "pareho" (consistent) with each other.
class NetflixColors {
  static const Color black = Color(0xFF000000);
  static const Color nearBlack = Color(0xFF141414);
  static const Color darkGrey = Color(0xFF181818);
  static const Color fieldGrey = Color(0xFF333333);
  static const Color red = Color(0xFFE50914);
  static const Color redDark = Color(0xFFB20710);
  static const Color grey = Color(0xFF8C8C8C);
  static const Color white = Color(0xFFFFFFFF);
}

class NetflixTextStyles {
  static const TextStyle logo = TextStyle(
    color: NetflixColors.red,
    fontSize: 36,
    fontWeight: FontWeight.w900,
    letterSpacing: 1.5,
  );

  static const TextStyle heading = TextStyle(
    color: NetflixColors.white,
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle body = TextStyle(
    color: NetflixColors.white,
    fontSize: 14,
  );

  static const TextStyle greyBody = TextStyle(
    color: NetflixColors.grey,
    fontSize: 14,
  );

  static const TextStyle link = TextStyle(
    color: NetflixColors.white,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
  );
}

/// Reusable input decoration so every text field on every screen
/// looks identical (dark filled box, grey label, red focus border).
InputDecoration netflixInputDecoration(String label) {
  return InputDecoration(
    filled: true,
    fillColor: NetflixColors.fieldGrey,
    labelText: label,
    labelStyle: const TextStyle(color: NetflixColors.grey, fontSize: 14),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: NetflixColors.white, width: 1.2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(color: NetflixColors.red, width: 1.2),
    ),
  );
}

/// Reusable big red "Netflix button" (Login / Sign Up buttons).
ButtonStyle netflixButtonStyle() {
  return ElevatedButton.styleFrom(
    backgroundColor: NetflixColors.red,
    foregroundColor: NetflixColors.white,
    minimumSize: const Size(double.infinity, 50),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    elevation: 0,
  );
}
