import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTextStyles {
  /// UI chrome text theme (buttons, labels, nav)
  static TextTheme get uiTextTheme => GoogleFonts.interTextTheme();

  /// Thai script display (large, for lessons/vocab)
  static TextStyle get thaiDisplay => GoogleFonts.sarabun(
        fontSize: 32,
        fontWeight: FontWeight.w500,
      );

  /// Thai script body text
  static TextStyle get thaiBody => GoogleFonts.sarabun(
        fontSize: 18,
        fontWeight: FontWeight.w400,
      );
}
