import 'package:flutter/material.dart';

import '../../../config/theme/app_colors.dart';

enum ToneType {
  mid,
  low,
  fall,
  high,
  rise;

  /// Chinese label for this tone
  String get label => switch (this) {
        ToneType.mid => '中平',
        ToneType.low => '低沉',
        ToneType.fall => '急降',
        ToneType.high => '高揚',
        ToneType.rise => '低升',
      };

  /// Thai name for this tone
  String get thaiName => switch (this) {
        ToneType.mid => 'สามัญ',
        ToneType.low => 'เอก',
        ToneType.fall => 'โท',
        ToneType.high => 'ตรี',
        ToneType.rise => 'จัตวา',
      };

  /// Tone mark symbol (or none)
  String get symbol => switch (this) {
        ToneType.mid => '（無符號）',
        ToneType.low => '่',
        ToneType.fall => '้',
        ToneType.high => '๊',
        ToneType.rise => '๋',
      };

  /// Chao tone number (五度標記)
  String get chaoNumber => switch (this) {
        ToneType.mid => '33',
        ToneType.low => '21',
        ToneType.fall => '41',
        ToneType.high => '45',
        ToneType.rise => '214',
      };

  /// Direction arrow(s) indicating tone contour
  String get arrow => switch (this) {
        ToneType.mid => '─',
        ToneType.low => '↘',
        ToneType.fall => '↘↘',
        ToneType.high => '↗↗',
        ToneType.rise => '↗',
      };

  /// 聽感 — how it feels when spoken
  String get feel => switch (this) {
        ToneType.mid => '全程在中間，不動',
        ToneType.low => '全程壓低，稍微再沉一點',
        ToneType.fall => '從高位急速摔落到最低點',
        ToneType.high => '從中高位繼續往上爬，停在最高點',
        ToneType.rise => '先往低谷沉，再大幅回升到高點',
      };

  /// 記憶法 — mnemonic for Chinese speakers
  String get memory => switch (this) {
        ToneType.mid => '像唸「嗯」，平靜，無起伏',
        ToneType.low => '像嘆氣說「唉」，沉，沒有反彈',
        ToneType.fall => '像用力說「不！」，從頭衝下來',
        ToneType.high => '像確認地問「真的？」，音往上頂',
        ToneType.rise => '像帶點撒嬌說「哦～」，先低再拉高',
      };

  /// 普通話對照
  String get mandarinRef => switch (this) {
        ToneType.mid => '最像普通話一聲，但音高略低於最高點',
        ToneType.low => '像普通話三聲起頭那段低沉的部分，但不回升',
        ToneType.fall => '非常接近普通話四聲，但起點更高、落差更大',
        ToneType.high => '近普通話二聲，但起點更高，升幅更平緩',
        ToneType.rise => '非常接近普通話三聲的完整形狀（低谷再回升）',
      };

  /// Example word
  String get example => switch (this) {
        ToneType.mid => 'กิน（kin，吃）',
        ToneType.low => 'ไป（bpai，去）',
        ToneType.fall => 'ข้าว（khâo，飯）、ชอบ（chôp，喜歡）',
        ToneType.high => 'สาม（sǎam，三）',
        ToneType.rise => 'ฉัน（chǎn，我）',
      };

  /// SVG path for tone contour curve (viewBox 0 0 80 80)
  String get svgPath => switch (this) {
        ToneType.mid => 'M 12 38 L 68 38',
        ToneType.low => 'M 12 53 L 68 65',
        ToneType.fall => 'M 12 18 C 28 18 52 58 68 70',
        ToneType.high => 'M 12 28 C 30 26 52 14 68 10',
        ToneType.rise => 'M 12 48 C 22 58 38 65 50 52 C 57 44 62 28 68 16',
      };

  /// Foreground color for this tone
  Color get color => switch (this) {
        ToneType.mid => AppColors.toneMid,
        ToneType.low => AppColors.toneLow,
        ToneType.fall => AppColors.toneFall,
        ToneType.high => AppColors.toneHigh,
        ToneType.rise => AppColors.toneRise,
      };

  /// Background color for this tone
  Color get backgroundColor => switch (this) {
        ToneType.mid => AppColors.toneMidBg,
        ToneType.low => AppColors.toneLowBg,
        ToneType.fall => AppColors.toneFallBg,
        ToneType.high => AppColors.toneHighBg,
        ToneType.rise => AppColors.toneRiseBg,
      };

  /// Parse from JSON string value
  static ToneType fromJson(String value) => ToneType.values.byName(value);

  /// Serialize to JSON string
  String toJson() => name;
}
