import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../data/models/thai_font.dart';
import '../../../../data/models/tone_type.dart';
import '../../application/analysis_controller.dart';
import '../widgets/learn_mode_view.dart';
import '../widgets/sentence_view.dart';
import '../widgets/tone_curve_painter.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(analysisControllerProvider);
    final isLearningMode = ref.watch(learningModeNotifierProvider);

    if (result == null) {
      // No result, go back to home
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) context.go('/');
      });
      return const Scaffold(body: SizedBox.shrink());
    }

    // Truncated input for app bar
    final title = result.input.length > 30
        ? '${result.input.substring(0, 30)}…'
        : result.input;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(fontSize: 14, color: AppColors.ink2),
        ),
        actions: [
          // Learning mode toggle
          GestureDetector(
            onTap: () =>
                ref.read(learningModeNotifierProvider.notifier).toggle(),
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    '學習',
                    style: TextStyle(fontSize: 12, color: AppColors.ink2),
                  ),
                  const SizedBox(width: 6),
                  _buildToggle(isLearningMode),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 80),
            children: [
              // Toolbar: font picker + tone bar
              _buildToolbar(context, ref),
              const SizedBox(height: 16),

              // Result
              isLearningMode
                  ? LearnModeView(words: result.words)
                  : SentenceView(words: result.words),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToolbar(BuildContext context, WidgetRef ref) {
    final currentFont = ref.watch(thaiFontNotifierProvider);

    return Row(
      children: [
        // Font pickers — circular buttons
        ...ThaiFontStyle.values.map((font) {
          final isActive = currentFont == font;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () =>
                  ref.read(thaiFontNotifierProvider.notifier).setFont(font),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: isActive ? AppColors.ink : Colors.transparent,
                  border: Border.all(
                    color: isActive ? AppColors.ink : AppColors.border2,
                  ),
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  'ก',
                  style: font.textStyle(fontSize: 16).copyWith(
                        color: isActive ? Colors.white : AppColors.ink2,
                      ),
                ),
              ),
            ),
          );
        }),
        const SizedBox(width: 4),
        // Tone bar — fills remaining space, 2 on top + 3 on bottom
        Expanded(
          child: GestureDetector(
            onTap: () => context.push('/tones'),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 8, vertical: 10),
              decoration: BoxDecoration(
                color: AppColors.surface,
                border: Border.all(color: AppColors.border),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (final tone in ToneType.values)
                    _toneItem(tone),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _toneItem(ToneType tone) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 16,
          height: 11,
          child: CustomPaint(
            painter: ToneCurvePainter(tone: tone, strokeWidth: 1.2),
          ),
        ),
        const SizedBox(width: 2),
        Text(
          tone.label,
          style: TextStyle(
            fontSize: 9,
            color: tone.color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildToggle(bool isOn) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 32,
      height: 18,
      decoration: BoxDecoration(
        color: isOn ? AppColors.ink : AppColors.surface2,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: AppColors.border2),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 200),
        alignment: isOn ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.all(2),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
