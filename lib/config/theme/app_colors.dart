import 'package:flutter/material.dart';

abstract final class AppColors {
  // Background & surface — warm, earthy, paper-like
  static const bg = Color(0xFFF5F2EC);
  static const surface = Color(0xFFFDFAF5);
  static const surface2 = Color(0xFFEDE9E1);

  // Ink hierarchy
  static const ink = Color(0xFF1C1812);
  static const ink2 = Color(0xFF5C5446);
  static const ink3 = Color(0xFF9C9282);

  // Accent
  static const accent = Color(0xFFC4561A);

  // Borders
  static final border = const Color(0xFF3C321E).withValues(alpha: 0.12);
  static final border2 = const Color(0xFF3C321E).withValues(alpha: 0.22);

  // Tone colors — five Thai tones (matching 0319-tones.html)
  static const toneMid = Color(0xFF6B6965);
  static const toneLow = Color(0xFF1E5E96);
  static const toneFall = Color(0xFFA02828);
  static const toneHigh = Color(0xFF9A6310);
  static const toneRise = Color(0xFF2D6030);

  // Tone backgrounds (10% opacity of tone color)
  static const toneMidBg = Color(0xFFEEECE8);
  static const toneLowBg = Color(0xFFE2EDF5);
  static const toneFallBg = Color(0xFFF5E4E4);
  static const toneHighBg = Color(0xFFF5EDD6);
  static const toneRiseBg = Color(0xFFE4EFE5);

  // Semantic
  static const error = Color(0xFFB00020);
  static const success = Color(0xFF2E7D32);

  // Dark mode variants
  static const bgDark = Color(0xFF1A1816);
  static const surfaceDark = Color(0xFF252220);
  static const surface2Dark = Color(0xFF342F2A);
  static const inkDark = Color(0xFFEDE9E1);
  static const ink2Dark = Color(0xFFAEA89E);
  static const ink3Dark = Color(0xFF7A7468);
}
