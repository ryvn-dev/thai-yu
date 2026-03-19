import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../config/theme/app_colors.dart';
import '../../../../config/theme/app_text_styles.dart';
import '../../../../data/models/tone_type.dart';

class ToneLegend extends StatefulWidget {
  const ToneLegend({super.key});

  @override
  State<ToneLegend> createState() => _ToneLegendState();
}

class _ToneLegendState extends State<ToneLegend> {
  ToneType? _activeTone;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 5-column tone grid
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
          child: Column(
            children: [
              Row(
                children: ToneType.values
                    .map((t) => Expanded(child: _buildToneCell(t)))
                    .toList(),
              ),
              // Detail panel
              if (_activeTone != null) ...[
                const SizedBox(height: 12),
                _buildDetailPanel(_activeTone!),
              ],
              if (_activeTone == null) ...[
                const SizedBox(height: 12),
                const Text(
                  '點擊聲調查看普通話對照說明',
                  style: TextStyle(fontSize: 11, color: AppColors.ink3),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildToneCell(ToneType tone) {
    final isActive = _activeTone == tone;

    return GestureDetector(
      onTap: () {
        setState(() {
          _activeTone = _activeTone == tone ? null : tone;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 2),
        padding: const EdgeInsets.fromLTRB(4, 10, 4, 8),
        decoration: BoxDecoration(
          color: isActive ? tone.backgroundColor : Colors.transparent,
          border: Border.all(
            color: isActive ? tone.color : Colors.transparent,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            // Staff + contour curve
            SizedBox(
              width: 56,
              height: 52,
              child: CustomPaint(
                painter: _ToneStaffPainter(tone: tone),
              ),
            ),
            const SizedBox(height: 5),
            // Chinese label
            Text(
              tone.label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: tone.color,
              ),
              textAlign: TextAlign.center,
            ),
            // Thai name
            Text(
              tone.thaiName,
              style: const TextStyle(
                fontSize: 9,
                fontFamily: 'Noto Serif Thai',
                color: AppColors.ink3,
              ),
              textAlign: TextAlign.center,
            ),
            // Chao number
            Text(
              tone.chaoNumber,
              style: AppTextStyles.mono.copyWith(
                fontSize: 9,
                color: AppColors.ink3,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailPanel(ToneType tone) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 150),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border2),
          borderRadius: BorderRadius.circular(16),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 12),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.border)),
              ),
              child: Row(
                children: [
                  Text(
                    tone.label,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: tone.color,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.surface2,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      tone.symbol,
                      style: AppTextStyles.mono.copyWith(
                        fontSize: 12,
                        color: AppColors.ink2,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '五度值 ${tone.chaoNumber}',
                    style: AppTextStyles.mono.copyWith(
                      fontSize: 11,
                      color: AppColors.ink3,
                    ),
                  ),
                ],
              ),
            ),
            // Body: info rows + larger staff
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info rows
                  Expanded(
                    child: Column(
                      children: [
                        _buildInfoRow('聽感', tone.feel),
                        _buildInfoRow('記憶法', tone.memory,
                            valueColor: tone.color, bold: true),
                        _buildInfoRow('普通話', tone.mandarinRef),
                        _buildInfoRow('例詞', tone.example,
                            valueColor: tone.color, bold: true),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Larger staff
                  SizedBox(
                    width: 88,
                    height: 80,
                    child: CustomPaint(
                      painter: _ToneStaffPainter(tone: tone, strokeWidth: 2.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value, {
    Color? valueColor,
    bool bold = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 48,
            child: Text(
              label,
              style: const TextStyle(fontSize: 11, color: AppColors.ink3),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 13,
                color: valueColor ?? AppColors.ink,
                fontWeight: bold ? FontWeight.w500 : FontWeight.w400,
                height: 1.55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Paints a 5-line staff with a tone contour curve
class _ToneStaffPainter extends CustomPainter {
  const _ToneStaffPainter({required this.tone, this.strokeWidth = 2.0});

  final ToneType tone;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Draw 5 horizontal staff lines
    final staffPaint = Paint()
      ..color = AppColors.border2
      ..strokeWidth = 0.5;
    final staffPaintMid = Paint()
      ..color = AppColors.border2
      ..strokeWidth = 0.8;

    const levels = [0.12, 0.30, 0.50, 0.70, 0.88];
    for (var i = 0; i < levels.length; i++) {
      final y = h * levels[i];
      final paint = i == 2 ? staffPaintMid : staffPaint;
      if (i == 2) {
        // Middle line is solid
        canvas.drawLine(Offset(6, y), Offset(w - 6, y), paint);
      } else {
        // Other lines are dashed
        _drawDashedLine(canvas, Offset(6, y), Offset(w - 6, y), paint, 4, 3);
      }
    }

    // Draw tone contour curve
    final curvePaint = Paint()
      ..color = tone.color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = _parseSvgPath(tone.svgPath, w, h);
    canvas.drawPath(path, curvePaint);

    // Draw end dot
    final endPoint = _getPathEndpoint(tone.svgPath, w, h);
    final dotPaint = Paint()..color = tone.color;
    canvas.drawCircle(endPoint, strokeWidth * 1.4, dotPaint);
  }

  Path _parseSvgPath(String svgPath, double w, double h) {
    // Scale from viewBox 0 0 80 80 to actual size
    final sx = w / 80;
    final sy = h / 80;

    final path = Path();
    final parts = svgPath.split(RegExp(r'(?=[MCL])'));

    for (final part in parts) {
      final trimmed = part.trim();
      if (trimmed.isEmpty) continue;

      final cmd = trimmed[0];
      final nums = RegExp(r'[-\d.]+')
          .allMatches(trimmed)
          .map((m) => double.parse(m.group(0)!))
          .toList();

      switch (cmd) {
        case 'M':
          path.moveTo(nums[0] * sx, nums[1] * sy);
        case 'L':
          path.lineTo(nums[0] * sx, nums[1] * sy);
        case 'C':
          path.cubicTo(
            nums[0] * sx,
            nums[1] * sy,
            nums[2] * sx,
            nums[3] * sy,
            nums[4] * sx,
            nums[5] * sy,
          );
      }
    }

    return path;
  }

  Offset _getPathEndpoint(String svgPath, double w, double h) {
    final sx = w / 80;
    final sy = h / 80;
    final nums = RegExp(r'[-\d.]+')
        .allMatches(svgPath)
        .map((m) => double.parse(m.group(0)!))
        .toList();
    return Offset(nums[nums.length - 2] * sx, nums[nums.length - 1] * sy);
  }

  void _drawDashedLine(
    Canvas canvas,
    Offset start,
    Offset end,
    Paint paint,
    double dashWidth,
    double dashSpace,
  ) {
    final dx = end.dx - start.dx;
    final dy = end.dy - start.dy;
    final dist = math.sqrt(dx * dx + dy * dy);

    if (dist == 0) return;

    final unitDx = dx / dist;
    final unitDy = dy / dist;
    var drawn = 0.0;
    var drawing = true;

    while (drawn < dist) {
      final segLen = drawing ? dashWidth : dashSpace;
      final nextDrawn = (drawn + segLen).clamp(0.0, dist);

      if (drawing) {
        canvas.drawLine(
          Offset(start.dx + unitDx * drawn, start.dy + unitDy * drawn),
          Offset(start.dx + unitDx * nextDrawn, start.dy + unitDy * nextDrawn),
          paint,
        );
      }

      drawn = nextDrawn;
      drawing = !drawing;
    }
  }

  @override
  bool shouldRepaint(_ToneStaffPainter oldDelegate) =>
      tone != oldDelegate.tone || strokeWidth != oldDelegate.strokeWidth;
}
