import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../analysis/application/analysis_controller.dart';
import '../../../analysis/presentation/widgets/input_card.dart';
import '../widgets/recent_analyses.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final _textController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _onAnalyze() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      await ref.read(analysisControllerProvider.notifier).analyze(text);
      if (mounted) {
        await context.push('/result');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _tryDemo() {
    _textController.text = 'ฉันชอบกินข้าวผัด';
    _onAnalyze();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 80),
              children: [
                // Header
                _buildHeader(),
                const SizedBox(height: 28),

                // Input card
                InputCard(
                  controller: _textController,
                  onAnalyze: _onAnalyze,
                  isLoading: _isLoading,
                ),
                const SizedBox(height: 16),

                // Recent analyses
                const RecentAnalyses(),
                const SizedBox(height: 16),

                // Tone bar
                _buildToneBar(),
                const SizedBox(height: 24),

                // Empty state / try demo
                if (ref.watch(analysisControllerProvider) == null)
                  _buildEmptyState(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ไทยหยู่',
              style: AppTextStyles.thaiLogo.copyWith(color: AppColors.ink3),
            ),
            const SizedBox(height: 1),
            const Text(
              '泰嶼',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.03 * 20,
                color: AppColors.ink,
              ),
            ),
          ],
        ),
        const Spacer(),
        IconButton(
          onPressed: () => context.push('/settings'),
          icon: const Icon(Icons.settings_outlined,
              color: AppColors.ink3, size: 20),
          visualDensity: VisualDensity.compact,
        ),
      ],
    );
  }

  Widget _buildToneBar() {
    return GestureDetector(
      onTap: () => context.push('/tones'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.music_note_rounded, size: 16, color: AppColors.ink3),
            SizedBox(width: 8),
            Text(
              '查看聲調卡片',
              style: TextStyle(fontSize: 13, color: AppColors.ink2),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border2),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            'ยินดีต้อนรับ',
            style: AppTextStyles.thaiDisplay.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.w300,
              color: AppColors.ink3,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '在上方貼入泰文，\n每個詞的聲母、韻母、聲調\n都會一一分解給你看。',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.ink3,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: _tryDemo,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.border2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '試試看 →',
                style: TextStyle(fontSize: 13, color: AppColors.ink2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
