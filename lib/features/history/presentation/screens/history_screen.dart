import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../data/datasources/analysis_cache.dart';
import '../../../../data/models/analysis_result.dart';
import '../../../../data/models/word_block.dart';
import '../../../analysis/application/analysis_controller.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final _searchController = TextEditingController();
  List<CachedAnalyse>? _items;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAll();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadAll() async {
    final db = await ref.read(analysisDatabaseProvider.future);
    final items = await db.getAllAnalyses();
    if (mounted) setState(() { _items = items; _isLoading = false; });
  }

  Future<void> _search(String query) async {
    final db = await ref.read(analysisDatabaseProvider.future);
    final items = query.isEmpty
        ? await db.getAllAnalyses()
        : await db.searchAnalyses(query);
    if (mounted) setState(() => _items = items);
  }

  Future<void> _delete(CachedAnalyse item) async {
    final db = await ref.read(analysisDatabaseProvider.future);
    await db.deleteAnalysis(item.hash);
    setState(() => _items?.remove(item));
  }

  void _openResult(CachedAnalyse item) {
    // Parse cached response and navigate to result
    final decoded = jsonDecode(item.response) as List<dynamic>;
    final words = decoded
        .map((e) => WordBlock.fromJson(e as Map<String, dynamic>))
        .toList();
    ref.read(analysisControllerProvider.notifier).setResult(AnalysisResult(
      input: item.input,
      words: words,
      analyzedAt: DateTime.fromMillisecondsSinceEpoch(item.createdAt),
    ));
    context.push('/result');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '分析記錄',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            children: [
              // Search bar
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: TextField(
                  controller: _searchController,
                  onChanged: _search,
                  style: AppTextStyles.thaiInput
                      .copyWith(color: AppColors.ink, fontSize: 16),
                  decoration: InputDecoration(
                    hintText: '搜尋…',
                    hintStyle: const TextStyle(
                        fontSize: 14, color: AppColors.ink3),
                    prefixIcon: const Icon(Icons.search_rounded,
                        size: 18, color: AppColors.ink3),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: AppColors.ink3),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    filled: true,
                    fillColor: AppColors.surface,
                  ),
                ),
              ),
              // List
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : _items == null || _items!.isEmpty
                        ? const Center(
                            child: Text(
                              '尚無分析記錄',
                              style: TextStyle(
                                  fontSize: 14, color: AppColors.ink3),
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.fromLTRB(
                                20, 4, 20, 80),
                            itemCount: _items!.length,
                            itemBuilder: (context, i) =>
                                _buildItem(_items![i]),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(CachedAnalyse item) {
    final display = item.input.length > 60
        ? '${item.input.substring(0, 60)}…'
        : item.input;
    final date = DateTime.fromMillisecondsSinceEpoch(item.createdAt);
    final dateStr =
        '${date.month}/${date.day} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';

    return Dismissible(
      key: Key(item.hash),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 16),
        color: const Color(0xFFEF5350),
        child: const Icon(Icons.delete_rounded, color: Colors.white, size: 20),
      ),
      onDismissed: (_) => _delete(item),
      child: GestureDetector(
        onTap: () => _openResult(item),
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      display,
                      style: AppTextStyles.thaiInput.copyWith(
                        fontSize: 16,
                        color: AppColors.ink,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateStr,
                      style: const TextStyle(
                          fontSize: 11, color: AppColors.ink3),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded,
                  size: 18, color: AppColors.ink3),
            ],
          ),
        ),
      ),
    );
  }
}
