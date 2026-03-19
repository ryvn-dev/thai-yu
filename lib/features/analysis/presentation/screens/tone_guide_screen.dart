import 'package:flutter/material.dart';

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
            ],
          ),
        ),
      ),
    );
  }
}
