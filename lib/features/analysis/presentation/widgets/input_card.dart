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
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Top area: label + paste icon
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 8, 0),
            child: Row(
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
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    final data =
                        await Clipboard.getData(Clipboard.kTextPlain);
                    if (data?.text?.isNotEmpty ?? false) {
                      controller.text = data!.text!;
                      controller.selection = TextSelection.collapsed(
                        offset: controller.text.length,
                      );
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                  child: const Padding(
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.content_paste_rounded,
                      size: 16,
                      color: AppColors.ink3,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Text field
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
            child: TextField(
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
              ),
              maxLines: 3,
              minLines: 2,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => onAnalyze(),
            ),
          ),
          // Analyze button — flush to bottom, border-top only
          GestureDetector(
            onTap: isLoading ? null : onAnalyze,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.ink,
                border: Border(
                  top: BorderSide(color: AppColors.border),
                ),
              ),
              padding: const EdgeInsets.symmetric(vertical: 12),
              alignment: Alignment.center,
              child: isLoading
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text(
                      '解析 →',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.01 * 13,
                        color: Colors.white,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
