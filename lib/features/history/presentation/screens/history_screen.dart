import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '分析記錄',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history_rounded, size: 48, color: AppColors.ink3),
            SizedBox(height: 12),
            Text(
              '即將推出',
              style: TextStyle(fontSize: 16, color: AppColors.ink3),
            ),
            SizedBox(height: 6),
            Text(
              '完整的分析記錄瀏覽與搜尋功能',
              style: TextStyle(fontSize: 13, color: AppColors.ink3),
            ),
          ],
        ),
      ),
    );
  }
}
