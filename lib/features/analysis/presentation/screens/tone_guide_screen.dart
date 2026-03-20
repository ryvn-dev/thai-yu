import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/app_colors.dart';
import '../widgets/tone_legend.dart';

class ToneGuideScreen extends StatelessWidget {
  const ToneGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '泰語聲調對照',
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
                '五個聲調的音高走勢 — 對照普通話的聲學記憶',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.ink3,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 16),
              const ToneLegend(),
              const SizedBox(height: 20),
              // Link to consonant reference
              GestureDetector(
                onTap: () => context.push('/consonants'),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    border: Border.all(color: AppColors.border),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.abc_rounded,
                          size: 18, color: AppColors.ink3),
                      SizedBox(width: 8),
                      Text(
                        '查看 44 個聲母分類表',
                        style:
                            TextStyle(fontSize: 13, color: AppColors.ink2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
