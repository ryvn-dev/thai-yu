import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../data/datasources/analysis_cache.dart';
import '../../../../data/datasources/tts_service.dart';
import '../../../../data/models/tone_type.dart';
import '../../../../data/models/word_block.dart';
import 'tone_curve_painter.dart';

/// Shows pronunciation card as a bottom sheet, starting low.
void showPronunciationSheet(BuildContext context, WordBlock word) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.pop(context),
      child: DraggableScrollableSheet(
        initialChildSize: 0.35,
        minChildSize: 0.1,
        maxChildSize: 0.85,
        snap: true,
        snapSizes: const [0.35, 0.6, 0.85],
        builder: (context, scrollController) => GestureDetector(
          onTap: () {}, // prevent tap-through to dismiss
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColors.surface,
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: PronunciationCard(word: word),
            ),
          ),
        ),
      ),
    ),
  );
}

class PronunciationCard extends ConsumerWidget {
  const PronunciationCard({super.key, required this.word});

  final WordBlock word;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tone = word.tones.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Drag handle
        Center(
          child: Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 36,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.ink3.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),

        // Header: Thai (tappable for TTS) + roman + gloss
        Container(
          padding: const EdgeInsets.fromLTRB(18, 8, 18, 14),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: AppColors.border)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              GestureDetector(
                onTap: () => ref.read(ttsServiceProvider).speak(word.thai),
                child: word.originalSyllables.length > 1 &&
                        word.originalSyllables.length == word.tones.length
                    ? RichText(
                        text: TextSpan(
                          children: List.generate(
                              word.originalSyllables.length, (i) {
                            return TextSpan(
                              text: word.originalSyllables[i],
                              style: AppTextStyles.thaiHeadline
                                  .copyWith(color: word.tones[i].color),
                            );
                          }),
                        ),
                      )
                    : Text(
                        word.thai,
                        style: AppTextStyles.thaiHeadline
                            .copyWith(color: tone.color),
                      ),
              ),
              const SizedBox(width: 10),
              Text(
                word.roman,
                style: AppTextStyles.monoLarge.copyWith(color: AppColors.ink2),
              ),
              const Spacer(),
              Text(
                word.gloss,
                style: const TextStyle(fontSize: 13, color: AppColors.ink3),
              ),
              const SizedBox(width: 6),
              _SaveWordButton(word: word),
              const SizedBox(width: 6),
              // TTS speed toggle
              Consumer(builder: (context, ref, _) {
                final speed = ref.watch(ttsSpeedNotifierProvider);
                return GestureDetector(
                  onTap: () =>
                      ref.read(ttsSpeedNotifierProvider.notifier).cycle(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.surface2,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      speed.label,
                      style: const TextStyle(
                          fontSize: 9, color: AppColors.ink3),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),

        // Per-syllable phoneme breakdown
        ...word.syllableBreakdowns.map((syl) => _buildSyllableSection(syl, ref)),

        // Bottom padding
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildSyllableSection(SyllableBreakdown syl, WidgetRef ref) {
    final sylTone = ToneType.values.firstWhere(
      (t) => t.name == syl.tone,
      orElse: () => ToneType.mid,
    );

    final origThai =
        syl.originalThai.isNotEmpty ? syl.originalThai : syl.thai;
    final showPron = origThai != syl.thai; // pronunciate differs

    // Sub-word gloss from backend
    final sylGloss = syl.gloss;
    final showSylGloss =
        sylGloss != '…' && sylGloss != word.gloss && word.tones.length > 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Syllable header: original + rtgs + badges ... gloss (right-aligned)
        Container(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 6),
          child: Row(
            children: [
              Expanded(
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 5,
                  runSpacing: 4,
                  children: [
                    // Original spelling — tap to hear this syllable
                    GestureDetector(
                      onTap: () => ref.read(ttsServiceProvider).speak(syl.thai),
                      child: Text(
                        origThai,
                        style: AppTextStyles.thaiPhoneme.copyWith(
                          color: sylTone.color,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    // Pronunciation in parentheses (if different)
                    if (showPron)
                      Text(
                        '(${syl.thai})',
                        style:
                            const TextStyle(fontSize: 12, color: AppColors.ink3),
                      ),
                    Text(
                      syl.rtgs,
                      style: AppTextStyles.mono.copyWith(color: AppColors.ink3),
                    ),
                    // Badges: flags + tone
                    if (syl.isHoNam)
                      _badge('ห นำ', AppColors.toneLow, AppColors.toneLowBg),
                    if (syl.hasImplicitVowel)
                      _badge(
                          '隱含元音', AppColors.toneHigh, AppColors.toneHighBg),
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
              // Sub-word gloss (right-aligned)
              if (showSylGloss)
                Text(
                  sylGloss,
                  style: const TextStyle(fontSize: 12, color: AppColors.ink3),
                ),
            ],
          ),
        ),
        // Parts
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 4),
          child: Column(
            children: syl.parts
                .map((p) => _buildPhonemeRow(p, sylTone))
                .toList(),
          ),
        ),
        // Tone reason for this syllable
        if (syl.toneReason.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
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

  Widget _buildPhonemeRow(PhonemeBreakdown part, ToneType tone) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
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
          const Text(
            '→',
            style: TextStyle(fontSize: 12, color: AppColors.ink3),
          ),
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

class _SaveWordButton extends ConsumerStatefulWidget {
  const _SaveWordButton({required this.word});
  final WordBlock word;

  @override
  ConsumerState<_SaveWordButton> createState() => _SaveWordButtonState();
}

class _SaveWordButtonState extends ConsumerState<_SaveWordButton> {
  bool _saved = false;

  @override
  void initState() {
    super.initState();
    _checkSaved();
  }

  Future<void> _checkSaved() async {
    final db = await ref.read(analysisDatabaseProvider.future);
    final saved = await db.isWordSaved(widget.word.thai);
    if (mounted) setState(() => _saved = saved);
  }

  Future<void> _toggleSave() async {
    final db = await ref.read(analysisDatabaseProvider.future);
    if (_saved) {
      await db.deleteSavedWordByThai(widget.word.thai);
    } else {
      await db.saveWord(
        thai: widget.word.thai,
        roman: widget.word.roman,
        gloss: widget.word.gloss,
        toneJson: jsonEncode(widget.word.tones.map((t) => t.name).toList()),
        sourceText: '',
        wordJson: jsonEncode(widget.word.toJson()),
      );
    }
    if (mounted) setState(() => _saved = !_saved);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSave,
      child: Icon(
        _saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
        size: 20,
        color: _saved ? AppColors.ink : AppColors.ink3,
      ),
    );
  }
}
