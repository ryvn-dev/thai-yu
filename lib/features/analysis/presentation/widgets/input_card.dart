import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';

class InputCard extends StatelessWidget {
  const InputCard({
    super.key,
    required this.controller,
    required this.onAnalyze,
    this.isLoading = false,
  });

  final TextEditingController controller;
  final VoidCallback onAnalyze;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '貼入泰文',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.08 * 11,
                  color: AppColors.ink3,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: controller,
                style: AppTextStyles.thaiInput.copyWith(color: AppColors.ink),
                decoration: InputDecoration(
                  hintText: 'ลองพิมพ์ภาษาไทยที่นี่…',
                  hintStyle: AppTextStyles.thaiInput.copyWith(
                    color: AppColors.ink3,
                    fontSize: 18,
                  ),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  fillColor: Colors.transparent,
                  filled: true,
                  suffixIcon: GestureDetector(
                    onTap: () async {
                      final data = await Clipboard.getData(Clipboard.kTextPlain);
                      if (data?.text?.isNotEmpty ?? false) {
                        controller.text = data!.text!;
                        controller.selection = TextSelection.collapsed(
                          offset: controller.text.length,
                        );
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Icon(
                        Icons.content_paste_rounded,
                        size: 18,
                        color: AppColors.ink3,
                      ),
                    ),
                  ),
                  suffixIconConstraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 24,
                  ),
                ),
                maxLines: 3,
                minLines: 2,
                textInputAction: TextInputAction.done,
                onSubmitted: (_) => onAnalyze(),
              ),
              const SizedBox(height: 32),
            ],
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: ElevatedButton(
              onPressed: isLoading ? null : onAnalyze,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.ink,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.01 * 13,
                ),
              ),
              child: isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('解析 →'),
            ),
          ),
        ],
      ),
    );
  }
}
