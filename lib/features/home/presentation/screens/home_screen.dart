import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../data/datasources/backend_service.dart';
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
  bool? _backendHealthy;
  Timer? _healthTimer;

  @override
  void initState() {
    super.initState();
    _checkHealth();
    _healthTimer = Timer.periodic(
      const Duration(seconds: 30),
      (_) => _checkHealth(),
    );
  }

  @override
  void dispose() {
    _healthTimer?.cancel();
    _textController.dispose();
    super.dispose();
  }

  Future<void> _checkHealth() async {
    final healthy = await ref.read(backendServiceProvider).isHealthy();
    if (mounted) setState(() => _backendHealthy = healthy);
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
    } on SocketException catch (_) {
      if (mounted) {
        _showErrorSnackBar('無法連接分析服務，請確認後端已啟動');
      }
    } on TimeoutException catch (_) {
      if (mounted) {
        _showErrorSnackBar('分析逾時，請重試');
      }
    } catch (e) {
      if (mounted) {
        final msg = e.toString();
        if (msg.contains('Connection refused') ||
            msg.contains('SocketException')) {
          _showErrorSnackBar('無法連接分析服務，請確認後端已啟動');
        } else {
          _showErrorSnackBar('分析失敗: ${_friendlyError(msg)}');
        }
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: '重試',
          onPressed: _onAnalyze,
        ),
        duration: const Duration(seconds: 4),
      ),
    );
  }

  String _friendlyError(String raw) {
    if (raw.contains('BackendException')) {
      final match = RegExp(r':\s*(.+)$').firstMatch(raw);
      return match?.group(1) ?? raw;
    }
    return raw;
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
        // Nav icons: vocabulary, history, settings (with health dot)
        _headerIcon(
          Icons.bookmark_border_rounded,
          onTap: () => context.push('/vocabulary'),
        ),
        _headerIcon(
          Icons.history_rounded,
          onTap: () => context.push('/history'),
        ),
        Stack(
          children: [
            _headerIcon(
              Icons.settings_outlined,
              onTap: () => context.push('/settings'),
            ),
            // Backend health dot overlaid on settings icon
            if (_backendHealthy != null)
              Positioned(
                right: 6,
                top: 6,
                child: GestureDetector(
                  onTap: _checkHealth,
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: _backendHealthy!
                          ? const Color(0xFF4CAF50)
                          : const Color(0xFFEF5350),
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: AppColors.surface, width: 1.5),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Widget _headerIcon(IconData icon, {required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: AppColors.ink3, size: 20),
      ),
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
