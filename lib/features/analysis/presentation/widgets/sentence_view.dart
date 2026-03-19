import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../data/datasources/tts_service.dart';
import '../../../../data/models/word_block.dart';
import 'pronunciation_card.dart';
import 'word_chip.dart';

class SentenceView extends ConsumerWidget {
  const SentenceView({
    super.key,
    required this.words,
  });

  final List<WordBlock> words;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Group words by sentenceIndex
    final sentences = <int, List<WordBlock>>{};
    for (final w in words) {
      sentences.putIfAbsent(w.sentenceIndex, () => []).add(w);
    }

    final sortedKeys = sentences.keys.toList()..sort();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          for (var i = 0; i < sortedKeys.length; i++) ...[
            if (i > 0) const SizedBox(height: 12),
            _buildSentenceRow(context, ref, sentences[sortedKeys[i]]!),
          ],
        ],
      ),
    );
  }

  Widget _buildSentenceRow(
    BuildContext context,
    WidgetRef ref,
    List<WordBlock> sentenceWords,
  ) {
    final sentenceText = sentenceWords.map((w) => w.thai).join('');

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Play button for this sentence
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: GestureDetector(
            onTap: () => ref.read(ttsServiceProvider).speak(sentenceText),
            child: const Icon(
              Icons.play_arrow_rounded,
              size: 20,
              color: AppColors.ink3,
            ),
          ),
        ),
        const SizedBox(width: 4),
        // Word chips
        Expanded(
          child: Wrap(
            spacing: 4,
            runSpacing: 6,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: sentenceWords.map((w) {
              return WordChip(
                word: w,
                onTap: () => showPronunciationSheet(context, w),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
