import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../data/datasources/analysis_cache.dart';
import '../../../../data/datasources/tts_service.dart';
import '../../../../data/models/tone_type.dart';
import '../../../../data/models/word_block.dart';
import '../../../analysis/presentation/widgets/pronunciation_card.dart';

class VocabularyScreen extends ConsumerStatefulWidget {
  const VocabularyScreen({super.key});

  @override
  ConsumerState<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends ConsumerState<VocabularyScreen> {
  List<SavedWord>? _words;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final db = await ref.read(analysisDatabaseProvider.future);
    final words = await db.getAllSavedWords();
    if (mounted) setState(() { _words = words; _isLoading = false; });
  }

  Future<void> _delete(SavedWord word) async {
    final db = await ref.read(analysisDatabaseProvider.future);
    await db.deleteSavedWord(word.id);
    setState(() => _words?.removeWhere((w) => w.id == word.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '詞彙本',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        actions: [
          if (_words != null && _words!.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Text(
                  '${_words!.length} 詞',
                  style: const TextStyle(fontSize: 12, color: AppColors.ink3),
                ),
              ),
            ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(strokeWidth: 2))
              : _words == null || _words!.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 80),
                      itemCount: _words!.length,
                      itemBuilder: (context, i) => _buildItem(_words![i]),
                    ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bookmark_border_rounded, size: 48, color: AppColors.ink3),
          SizedBox(height: 12),
          Text(
            '尚未收藏任何詞彙',
            style: TextStyle(fontSize: 14, color: AppColors.ink3),
          ),
          SizedBox(height: 6),
          Text(
            '在分析結果中點擊書籤圖示收藏詞彙',
            style: TextStyle(fontSize: 12, color: AppColors.ink3),
          ),
        ],
      ),
    );
  }

  Widget _buildColoredThai(SavedWord item) {
    final tones = (jsonDecode(item.toneJson) as List<dynamic>)
        .map((t) => ToneType.values.firstWhere(
              (v) => v.name == t,
              orElse: () => ToneType.mid,
            ))
        .toList();

    // Try to get per-syllable coloring from wordJson
    try {
      final wordData =
          jsonDecode(item.wordJson) as Map<String, dynamic>;
      final syllables =
          (wordData['originalSyllables'] as List<dynamic>?)
              ?.cast<String>() ??
              [];
      if (syllables.length > 1 && syllables.length == tones.length) {
        return RichText(
          text: TextSpan(
            children: List.generate(syllables.length, (i) {
              return TextSpan(
                text: syllables[i],
                style: AppTextStyles.thaiInput.copyWith(
                  fontSize: 22,
                  color: tones[i].color,
                ),
              );
            }),
          ),
        );
      }
    } catch (_) {}

    return Text(
      item.thai,
      style: AppTextStyles.thaiInput.copyWith(
        fontSize: 22,
        color: tones.first.color,
      ),
    );
  }

  Widget _buildItem(SavedWord item) {
    return Dismissible(
      key: Key(item.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: const Color(0xFFEF5350),
        child: const Icon(Icons.delete_rounded, color: Colors.white, size: 20),
      ),
      onDismissed: (_) => _delete(item),
      child: GestureDetector(
        onTap: () {
          // Open pronunciation card
          try {
            final wordBlock = WordBlock.fromJson(
              jsonDecode(item.wordJson) as Map<String, dynamic>,
            );
            showPronunciationSheet(context, wordBlock);
          } catch (_) {
            // Fallback: just play TTS
            ref.read(ttsServiceProvider).speak(item.thai);
          }
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              // Thai text with per-syllable tone colors
              _buildColoredThai(item),
              const SizedBox(width: 10),
              // Roman + gloss
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.roman,
                      style: AppTextStyles.mono
                          .copyWith(color: AppColors.ink2),
                    ),
                    Text(
                      item.gloss,
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.ink3),
                    ),
                  ],
                ),
              ),
              // TTS play button
              GestureDetector(
                onTap: () => ref.read(ttsServiceProvider).speak(item.thai),
                child: const Icon(Icons.volume_up_rounded,
                    size: 18, color: AppColors.ink3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
