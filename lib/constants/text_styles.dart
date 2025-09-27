import 'package:flutter/material.dart';

class AppTextStyles {
  AppTextStyles._();

  // Display headline (e.g., onboarding titles)
  static const TextStyle display = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
    fontSize: 34,
    color: Colors.white,
  );

  // Section headline (e.g., location screen title)
  static const TextStyle headliner = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 1.3,
    color: Colors.white,
  );

  // Subheading or description
  static const TextStyle subhead = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.7,
    color: Colors.white70,
  );

  // Alarm time display
  static const TextStyle alarmTime = TextStyle(
    fontFamily: 'Oxygen',
    fontWeight: FontWeight.w600,
    fontSize: 24,
    color: Colors.white,
  );

  // General body text
  static const TextStyle body = TextStyle(
    fontFamily: 'Oxygen',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.48,
    color: Colors.white70,
  );

  // Smaller body text
  static const TextStyle bodyText1 = TextStyle(
    fontFamily: 'Oxygen',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    color: Colors.white70,
  );

  // Button text
  static const TextStyle buttonText = TextStyle(
    fontFamily: 'Oxygen',
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: Colors.white,
  );

  static const TextStyle button = buttonText;

  // Icon label or small caption
  static const TextStyle iconLabel = TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.7,
    color: Colors.white,
  );
}
