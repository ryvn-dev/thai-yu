import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum ThaiFontStyle {
  standard,
  rounded;

  String get label => switch (this) {
        ThaiFontStyle.standard => '印刷體',
        ThaiFontStyle.rounded => '圓體',
      };

  TextStyle textStyle({double fontSize = 30, FontWeight fontWeight = FontWeight.w400}) =>
      switch (this) {
        ThaiFontStyle.standard => GoogleFonts.notoSerifThai(
            fontSize: fontSize, fontWeight: fontWeight),
        ThaiFontStyle.rounded => GoogleFonts.ibmPlexSansThai(
            fontSize: fontSize, fontWeight: fontWeight),
      };
}
