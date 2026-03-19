import 'package:flutter/material.dart';

abstract final class AppColors {
  // Primary - warm gold inspired by Thai temples
  static const primary = Color(0xFFD4A843);
  static const primaryContainer = Color(0xFFFFF0C8);
  static const onPrimary = Color(0xFF1A1200);

  // Secondary - deep teal
  static const secondary = Color(0xFF00796B);
  static const secondaryContainer = Color(0xFFB2DFDB);

  // Tertiary - warm red (Thai flag accent)
  static const tertiary = Color(0xFFC62828);

  // Neutrals
  static const surface = Color(0xFFFFFBF5);
  static const surfaceDark = Color(0xFF1C1B1F);

  // Semantic
  static const success = Color(0xFF2E7D32);
  static const error = Color(0xFFB00020);
  static const warning = Color(0xFFF57C00);
}
