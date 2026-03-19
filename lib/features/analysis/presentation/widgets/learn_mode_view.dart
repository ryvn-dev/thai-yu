import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../data/datasources/tts_service.dart';
import '../../../../data/models/thai_font.dart';
import '../../../../data/models/tone_type.dart';
import '../../../../data/models/word_block.dart';
import '../../application/analysis_controller.dart';
import 'tone_curve_painter.dart';

class LearnModeView extends ConsumerWidget {
  const LearnModeView({super.key, required this.words});

  final List<WordBlock> words;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thaiFont = ref.watch(thaiFontNotifierProvider);

    return Column(
      children: words.map((word) => _buildCard(ref, word, thaiFont)).toList(),
    );
  }

  Widget _buildCard(WidgetRef ref, WordBlock word, ThaiFontStyle thaiFont) {
    final tone = word.tones.first;
    final headlineStyle = thaiFont.textStyle(fontSize: 34);

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header: tap Thai to play TTS
            Container(
              padding: const EdgeInsets.fromLTRB(18, 16, 18, 12),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  GestureDetector(
                    onTap: () =>
                        ref.read(ttsServiceProvider).speak(word.thai),
                    child: word.originalSyllables.length > 1 &&
                            word.originalSyllables.length == word.tones.length
                        ? RichText(
                            text: TextSpan(
                              children: List.generate(
                                  word.originalSyllables.length, (i) {
                                return TextSpan(
                                  text: word.originalSyllables[i],
                                  style: headlineStyle.copyWith(
                                      color: word.tones[i].color),
                                );
                              }),
                            ),
                          )
                        : Text(
                            word.thai,
                            style: headlineStyle.copyWith(color: tone.color),
                          ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    word.roman,
                    style: AppTextStyles.monoLarge
                        .copyWith(color: AppColors.ink2),
                  ),
                  const Spacer(),
                  Text(
                    word.gloss,
                    style:
                        const TextStyle(fontSize: 13, color: AppColors.ink3),
                  ),
                ],
              ),
            ),

            // Per-syllable phoneme parts (same structure as bottom sheet)
            if (word.syllableBreakdowns.isNotEmpty)
              ...word.syllableBreakdowns.map((syl) {
                final sylTone = ToneType.values.firstWhere(
                  (t) => t.name == syl.tone,
                  orElse: () => ToneType.mid,
                );
                final origThai = syl.originalThai.isNotEmpty
                    ? syl.originalThai
                    : syl.thai;
                final showPron = origThai != syl.thai;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Syllable header with badges
                    Container(
                      padding: const EdgeInsets.fromLTRB(18, 8, 18, 4),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 5,
                        runSpacing: 4,
                        children: [
                          Text(
                            origThai,
                            style: AppTextStyles.thaiPhoneme.copyWith(
                              color: sylTone.color,
                              fontSize: 16,
                            ),
                          ),
                          if (showPron)
                            Text(
                              '(${syl.thai})',
                              style: const TextStyle(
                                  fontSize: 12, color: AppColors.ink3),
                            ),
                          Text(
                            syl.rtgs,
                            style: AppTextStyles.mono
                                .copyWith(color: AppColors.ink3),
                          ),
                          if (syl.isHoNam)
                            _badge(
                                'ห นำ', AppColors.toneLow, AppColors.toneLowBg),
                          if (syl.hasImplicitVowel)
                            _badge('隱含元音', AppColors.toneHigh,
                                AppColors.toneHighBg),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 16,
                                height: 10,
                                child: CustomPaint(
                                  painter: ToneCurvePainter(
                                      tone: sylTone, strokeWidth: 1.2),
                                ),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                sylTone.label,
                                style: TextStyle(
                                  fontSize: 9,
                                  color: sylTone.color,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Parts
                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 0, 18, 4),
                      child: Column(
                        children: syl.parts
                            .map((p) => _buildRow(p, sylTone))
                            .toList(),
                      ),
                    ),
                    // Tone reason
                    if (syl.toneReason.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.fromLTRB(18, 0, 18, 8),
                        child: Text(
                          syl.toneReason,
                          style: TextStyle(
                            fontSize: 11,
                            color: sylTone.color.withValues(alpha: 0.7),
                            height: 1.5,
                          ),
                        ),
                      ),
                  ],
                );
              })
            else
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                child: Column(
                  children:
                      word.parts.map((p) => _buildRow(p, tone)).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _badge(String text, Color color, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text, style: TextStyle(fontSize: 9, color: color)),
    );
  }

  Widget _buildRow(PhonemeBreakdown part, ToneType tone) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          SizedBox(
            width: 32,
            child: Text(
              part.label,
              style: const TextStyle(fontSize: 11, color: AppColors.ink3),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            part.char_,
            style: AppTextStyles.thaiPhoneme.copyWith(color: tone.color),
          ),
          const SizedBox(width: 8),
          const Text('→',
              style: TextStyle(fontSize: 12, color: AppColors.ink3)),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 1),
            decoration: BoxDecoration(
              color: AppColors.surface2,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              part.sound,
              style: AppTextStyles.monoBadge.copyWith(color: AppColors.ink),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              part.zhApprox,
              style: const TextStyle(fontSize: 12, color: AppColors.ink2),
            ),
          ),
          if (part.isSilent) ...[
            const SizedBox(width: 4),
            const Text(
              '（不送氣）',
              style: TextStyle(
                fontSize: 10,
                color: AppColors.ink3,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
