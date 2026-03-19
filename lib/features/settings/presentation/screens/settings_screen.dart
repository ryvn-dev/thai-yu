import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../data/datasources/api_key_storage.dart';
import '../../../../data/datasources/openai_service.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _keyController = TextEditingController();
  bool _isValidating = false;
  _ValidationStatus _status = _ValidationStatus.none;

  @override
  void initState() {
    super.initState();
    // Load existing key
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final apiKeyAsync = ref.read(apiKeyNotifierProvider);
      final existing = apiKeyAsync.valueOrNull;
      if (existing != null && existing.isNotEmpty) {
        _keyController.text = existing;
        setState(() => _status = _ValidationStatus.saved);
      }
    });
  }

  @override
  void dispose() {
    _keyController.dispose();
    super.dispose();
  }

  Future<void> _validate() async {
    final key = _keyController.text.trim();
    if (key.isEmpty) return;

    setState(() {
      _isValidating = true;
      _status = _ValidationStatus.none;
    });

    final isValid = await OpenAiService.validateApiKey(key);

    if (isValid) {
      await ref.read(apiKeyNotifierProvider.notifier).setApiKey(key);
      if (mounted) setState(() => _status = _ValidationStatus.valid);
    } else {
      if (mounted) setState(() => _status = _ValidationStatus.invalid);
    }

    if (mounted) setState(() => _isValidating = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'API 設定',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              const Text(
                'OpenAI API Key',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.08 * 11,
                  color: AppColors.ink3,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  border: Border.all(color: AppColors.border),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: TextField(
                  controller: _keyController,
                  obscureText: true,
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    hintText: 'sk-...',
                    hintStyle: TextStyle(color: AppColors.ink3),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    fillColor: Colors.transparent,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _isValidating ? null : _validate,
                    child: _isValidating
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('驗證並儲存'),
                  ),
                  const SizedBox(width: 12),
                  _buildStatusIndicator(),
                ],
              ),
              const SizedBox(height: 24),
              const Text(
                'API Key 僅儲存於本機 Keychain，不會上傳至任何伺服器。',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.ink3,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIndicator() {
    return switch (_status) {
      _ValidationStatus.none => const SizedBox.shrink(),
      _ValidationStatus.valid || _ValidationStatus.saved => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: AppColors.success, size: 16),
            const SizedBox(width: 4),
            Text(
              _status == _ValidationStatus.saved ? '已儲存' : 'API Key 有效',
              style: const TextStyle(fontSize: 12, color: AppColors.success),
            ),
          ],
        ),
      _ValidationStatus.invalid => const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error, color: AppColors.error, size: 16),
            SizedBox(width: 4),
            Text(
              'API Key 無效',
              style: TextStyle(fontSize: 12, color: AppColors.error),
            ),
          ],
        ),
    };
  }
}

enum _ValidationStatus { none, valid, invalid, saved }
