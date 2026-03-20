import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../data/datasources/analysis_cache.dart';

part 'recent_analyses.g.dart';

@riverpod
Future<List<CachedAnalyse>> recentAnalyses(RecentAnalysesRef ref) async {
  final db = await ref.watch(analysisDatabaseProvider.future);
  return db.getRecentAnalyses(limit: 10);
}

class RecentAnalyses extends ConsumerWidget {
  const RecentAnalyses({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentsAsync = ref.watch(recentAnalysesProvider);

    return recentsAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, _) => const SizedBox.shrink(),
      data: (recents) {
        if (recents.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Text(
                '最近分析',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.08 * 11,
                  color: AppColors.ink3,
                ),
              ),
            ),
            SizedBox(
              height: 64,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: recents.length,
                separatorBuilder: (_, _) => const SizedBox(width: 8),
                itemBuilder: (context, i) =>
                    _buildCard(context, recents[i]),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCard(BuildContext context, CachedAnalyse item) {
    // Truncate input for display
    final display = item.input.length > 20
        ? '${item.input.substring(0, 20)}…'
        : item.input;

    return GestureDetector(
      onTap: () => context.push('/result', extra: item.hash),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              display,
              style: AppTextStyles.thaiInput.copyWith(
                fontSize: 16,
                color: AppColors.ink,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
