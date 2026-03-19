import 'package:flutter/material.dart';

import '../../../../data/models/tone_type.dart';

/// Paints a tone contour curve. Reused across tone bar, tone legend, etc.
class ToneCurvePainter extends CustomPainter {
  const ToneCurvePainter({required this.tone, this.strokeWidth = 2.0});

  final ToneType tone;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final sx = w / 80;
    final sy = h / 80;

    final paint = Paint()
      ..color = tone.color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = _parsePath(tone.svgPath, sx, sy);
    canvas.drawPath(path, paint);

    // End dot
    final endPoint = _getEndpoint(tone.svgPath, sx, sy);
    canvas.drawCircle(endPoint, strokeWidth * 0.9, Paint()..color = tone.color);
  }

  static Path _parsePath(String svgPath, double sx, double sy) {
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
            nums[0] * sx, nums[1] * sy,
            nums[2] * sx, nums[3] * sy,
            nums[4] * sx, nums[5] * sy,
          );
      }
    }
    return path;
  }

  static Offset _getEndpoint(String svgPath, double sx, double sy) {
    final nums = RegExp(r'[-\d.]+')
        .allMatches(svgPath)
        .map((m) => double.parse(m.group(0)!))
        .toList();
    return Offset(nums[nums.length - 2] * sx, nums[nums.length - 1] * sy);
  }

  @override
  bool shouldRepaint(ToneCurvePainter oldDelegate) =>
      tone != oldDelegate.tone || strokeWidth != oldDelegate.strokeWidth;
}
