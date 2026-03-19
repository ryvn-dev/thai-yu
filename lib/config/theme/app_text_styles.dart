import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTextStyles {
  /// UI text theme — DM Sans for all chrome
  static TextTheme get uiTextTheme => GoogleFonts.dmSansTextTheme();

  /// Thai script — large display (word chips, card headers)
  static TextStyle get thaiDisplay => GoogleFonts.notoSerifThai(
        fontSize: 30,
        fontWeight: FontWeight.w400,
        height: 1.2,
      );

  /// Thai script — extra large (pronunciation card head)
  static TextStyle get thaiHeadline => GoogleFonts.notoSerifThai(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        height: 1.0,
      );

  /// Thai script — input field
  static TextStyle get thaiInput => GoogleFonts.notoSerifThai(
        fontSize: 22,
        fontWeight: FontWeight.w300,
        height: 1.7,
      );

  /// Thai script — phoneme breakdown character
  static TextStyle get thaiPhoneme => GoogleFonts.notoSerifThai(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        height: 1.0,
      );

  /// Thai script — app logo
  static TextStyle get thaiLogo => GoogleFonts.notoSerifThai(
        fontSize: 13,
        fontWeight: FontWeight.w300,
        letterSpacing: 0.08 * 13,
      );

  /// Romanization / IPA — DM Mono
  static TextStyle get mono => GoogleFonts.dmMono(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.02 * 11,
      );

  /// Romanization — larger (card context)
  static TextStyle get monoLarge => GoogleFonts.dmMono(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      );

  /// IPA badge text
  static TextStyle get monoBadge => GoogleFonts.dmMono(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      );
}
