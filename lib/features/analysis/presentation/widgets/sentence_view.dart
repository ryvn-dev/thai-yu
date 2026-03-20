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
    this.sentenceGlosses = const {},
  });

  final List<WordBlock> words;
  final Map<int, String> sentenceGlosses;

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
            if (i > 0) ...[
              Divider(color: AppColors.border, height: 20, thickness: 0.5),
            ],
            _buildSentenceRow(
                context, ref, sentences[sortedKeys[i]]!, sortedKeys[i]),
          ],
        ],
      ),
    );
  }

  Widget _buildSentenceRow(
    BuildContext context,
    WidgetRef ref,
    List<WordBlock> sentenceWords,
    int sentenceIndex,
  ) {
    final sentenceText = sentenceWords.map((w) => w.thai).join('');
    final gloss = sentenceGlosses[sentenceIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
        ),
        // Sentence-level gloss
        if (gloss != null && gloss.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 28, top: 4, bottom: 2),
            child: Text(
              gloss,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.ink3,
                height: 1.4,
              ),
            ),
          ),
      ],
    );
  }
}
