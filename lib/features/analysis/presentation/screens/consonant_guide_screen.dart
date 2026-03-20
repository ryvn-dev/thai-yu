import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../data/datasources/tts_service.dart';

/// A Thai consonant with its classification data.
class _Consonant {
  const _Consonant(this.thai, this.rtgs, this.ipa, this.zhApprox, this.example);
  final String thai;
  final String rtgs;
  final String ipa;
  final String zhApprox;
  final String example; // example word
}

// Data sourced from thai_tables.py
const _highClass = [
  _Consonant('ข', 'kh', '/kʰ/', '可 kh-', 'ไข่'),
  _Consonant('ฃ', 'kh', '/kʰ/', '可 kh-', '(廢棄)'),
  _Consonant('ฉ', 'ch', '/tɕʰ/', '車 ch-', 'ฉัน'),
  _Consonant('ฐ', 'th', '/tʰ/', '他 th-', 'ฐาน'),
  _Consonant('ถ', 'th', '/tʰ/', '他 th-', 'ถูก'),
  _Consonant('ผ', 'ph', '/pʰ/', '坡 ph-', 'ผัด'),
  _Consonant('ฝ', 'f', '/f/', '佛 f-', 'ฝน'),
  _Consonant('ศ', 's', '/s/', '絲 s-', 'ศูนย์'),
  _Consonant('ษ', 's', '/s/', '絲 s-', 'ฤษี'),
  _Consonant('ส', 's', '/s/', '絲 s-', 'สาม'),
  _Consonant('ห', 'h', '/h/', '喝 h-', 'ห้า'),
];

const _midClass = [
  _Consonant('ก', 'k', '/k/', '格 k-', 'กิน'),
  _Consonant('จ', 'ch', '/tɕ/', '知 j-', 'จาน'),
  _Consonant('ฎ', 'd', '/d/', '得 d-', 'กฎ'),
  _Consonant('ฏ', 't', '/t/', '的 t-', 'ปฏิบัติ'),
  _Consonant('ด', 'd', '/d/', '得 d-', 'ดี'),
  _Consonant('ต', 't', '/t/', '的 t-', 'ตา'),
  _Consonant('บ', 'b', '/b/', '波 b-', 'บ้าน'),
  _Consonant('ป', 'p', '/p/', '玻 p-', 'ปลา'),
  _Consonant('อ', '', '/ʔ/', '喉塞音', 'อยู่'),
];

const _lowClass = [
  _Consonant('ค', 'kh', '/kʰ/', '可 kh-', 'คน'),
  _Consonant('ฅ', 'kh', '/kʰ/', '可 kh-', '(廢棄)'),
  _Consonant('ฆ', 'kh', '/kʰ/', '可 kh-', 'ฆ่า'),
  _Consonant('ง', 'ng', '/ŋ/', '昂 ng-', 'งู'),
  _Consonant('ช', 'ch', '/tɕʰ/', '車 ch-', 'ช้าง'),
  _Consonant('ซ', 's', '/s/', '絲 s-', 'ซ้าย'),
  _Consonant('ฌ', 'ch', '/tɕʰ/', '車 ch-', 'เฌอ'),
  _Consonant('ญ', 'y', '/j/', '牙 y-', 'ญี่ปุ่น'),
  _Consonant('ฑ', 'th', '/tʰ/', '他 th-', 'มณฑล'),
  _Consonant('ฒ', 'th', '/tʰ/', '他 th-', 'ผู้เฒ่า'),
  _Consonant('ณ', 'n', '/n/', '那 n-', 'คุณ'),
  _Consonant('ท', 'th', '/tʰ/', '他 th-', 'ที่'),
  _Consonant('ธ', 'th', '/tʰ/', '他 th-', 'ธง'),
  _Consonant('น', 'n', '/n/', '那 n-', 'น้ำ'),
  _Consonant('พ', 'ph', '/pʰ/', '坡 ph-', 'พ่อ'),
  _Consonant('ฟ', 'f', '/f/', '佛 f-', 'ฟัน'),
  _Consonant('ภ', 'ph', '/pʰ/', '坡 ph-', 'ภาษา'),
  _Consonant('ม', 'm', '/m/', '媽 m-', 'แม่'),
  _Consonant('ย', 'y', '/j/', '牙 y-', 'ยา'),
  _Consonant('ร', 'r', '/r/', '日 r-', 'เรา'),
  _Consonant('ล', 'l', '/l/', '了 l-', 'ลูก'),
  _Consonant('ว', 'w', '/w/', '我 w-', 'วัน'),
  _Consonant('ฬ', 'l', '/l/', '了 l-', 'จุฬา'),
  _Consonant('ฮ', 'h', '/h/', '喝 h-', 'ฮา'),
];

class ConsonantGuideScreen extends ConsumerWidget {
  const ConsonantGuideScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '泰語聲母表',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                '44 個泰語聲母分為三類，聲母類別決定聲調。',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.ink3,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 16),
              _buildClassSection(
                ref,
                '高類 (อักษรสูง)',
                _highClass,
                AppColors.toneHigh,
                AppColors.toneHighBg,
              ),
              const SizedBox(height: 16),
              _buildClassSection(
                ref,
                '中類 (อักษรกลาง)',
                _midClass,
                AppColors.toneMid,
                AppColors.toneMidBg,
              ),
              const SizedBox(height: 16),
              _buildClassSection(
                ref,
                '低類 (อักษรต่ำ)',
                _lowClass,
                AppColors.toneLow,
                AppColors.toneLowBg,
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClassSection(
    WidgetRef ref,
    String title,
    List<_Consonant> consonants,
    Color color,
    Color bgColor,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '$title — ${consonants.length} 個',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 8),
        ...consonants.map((c) => _buildConsonantRow(ref, c, color)),
      ],
    );
  }

  Widget _buildConsonantRow(WidgetRef ref, _Consonant c, Color classColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: GestureDetector(
        onTap: () => ref.read(ttsServiceProvider).speak(c.thai),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              // Thai letter
              SizedBox(
                width: 36,
                child: Text(
                  c.thai,
                  style: AppTextStyles.thaiPhoneme.copyWith(
                    color: classColor,
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // RTGS + IPA
              SizedBox(
                width: 60,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c.rtgs.isEmpty ? '(ø)' : c.rtgs,
                      style: AppTextStyles.mono.copyWith(color: AppColors.ink),
                    ),
                    Text(
                      c.ipa,
                      style: AppTextStyles.mono
                          .copyWith(color: AppColors.ink3, fontSize: 10),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              // Chinese approximation
              Expanded(
                child: Text(
                  c.zhApprox,
                  style: const TextStyle(fontSize: 12, color: AppColors.ink2),
                ),
              ),
              // Example word
              Text(
                c.example,
                style: AppTextStyles.thaiPhoneme.copyWith(
                  color: AppColors.ink3,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
