import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../data/datasources/tts_service.dart';
import '../../../../data/models/thai_font.dart';
import '../../../../data/models/word_block.dart';
import '../../application/analysis_controller.dart';

class WordChip extends ConsumerWidget {
  const WordChip({
    super.key,
    required this.word,
    required this.onTap,
  });

  final WordBlock word;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final thaiFont = ref.watch(thaiFontNotifierProvider);

    return GestureDetector(
      onTap: onTap,
      onLongPress: () {
        final text = '${word.thai} (${word.roman}) ${word.gloss}';
        Clipboard.setData(ClipboardData(text: text));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('已複製: $text'),
            duration: const Duration(seconds: 1),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        constraints: const BoxConstraints(minWidth: 52),
        child: Column(
          children: [
            // Thai text — per-syllable coloring, tap to play TTS
            GestureDetector(
              onTap: () => ref.read(ttsServiceProvider).speak(word.thai),
              child: _buildColoredThai(thaiFont),
            ),
            const SizedBox(height: 3),
            Text(
              word.roman,
              style: AppTextStyles.mono.copyWith(color: AppColors.ink2),
            ),
            const SizedBox(height: 1),
            Text(
              word.gloss,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.ink3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColoredThai(ThaiFontStyle thaiFont) {
    final baseStyle = thaiFont.textStyle(fontSize: 30);

    if (word.originalSyllables.length > 1 &&
        word.originalSyllables.length == word.tones.length) {
      return RichText(
        text: TextSpan(
          children: List.generate(word.originalSyllables.length, (i) {
            return TextSpan(
              text: word.originalSyllables[i],
              style: baseStyle.copyWith(color: word.tones[i].color),
            );
          }),
        ),
      );
    }

    final tone = word.tones.first;
    return Text(
      word.thai,
      style: baseStyle.copyWith(color: tone.color),
    );
  }
}
