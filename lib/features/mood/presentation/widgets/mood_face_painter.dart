import 'dart:math';
import 'package:flutter/material.dart';
import '../../domain/entities/mood_entry.dart';

class MoodFacePainter extends CustomPainter {
  final Mood mood;
  final Color color;

  MoodFacePainter({required this.mood, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width / 2, size.height / 2);

    // Draw face circle
    final facePaint = Paint()
      ..color = color.withValues(alpha: 0.2)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, radius, facePaint);

    final borderPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(center, radius, borderPaint);

    // Draw eyes
    final eyePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final eyeOffset = radius * 0.35;
    final eyeRadius = radius * 0.1;

    canvas.drawCircle(
      Offset(center.dx - eyeOffset, center.dy - eyeOffset),
      eyeRadius,
      eyePaint,
    );
    canvas.drawCircle(
      Offset(center.dx + eyeOffset, center.dy - eyeOffset),
      eyeRadius,
      eyePaint,
    );

    // Draw mouth
    final mouthPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    if (mood == Mood.happy) {
      final rect = Rect.fromCircle(center: center, radius: radius * 0.6);
      canvas.drawArc(rect, 0.2, pi - 0.4, false, mouthPaint);

      // Add happy eyebrows
      final eyebrowPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawLine(
        Offset(center.dx - eyeOffset - 5, center.dy - eyeOffset - 5),
        Offset(center.dx - eyeOffset + 5, center.dy - eyeOffset - 5),
        eyebrowPaint,
      );
      canvas.drawLine(
        Offset(center.dx + eyeOffset + 5, center.dy - eyeOffset - 5),
        Offset(center.dx + eyeOffset - 5, center.dy - eyeOffset - 5),
        eyebrowPaint,
      );
    } else if (mood == Mood.neutral) {
      canvas.drawLine(
        Offset(center.dx - radius * 0.4, center.dy + radius * 0.3),
        Offset(center.dx + radius * 0.4, center.dy + radius * 0.3),
        mouthPaint,
      );

      // Add neutral eyebrows
      final eyebrowPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawLine(
        Offset(center.dx - eyeOffset - 5, center.dy - eyeOffset - 5),
        Offset(center.dx - eyeOffset + 5, center.dy - eyeOffset - 5),
        eyebrowPaint,
      );
      canvas.drawLine(
        Offset(center.dx + eyeOffset + 5, center.dy - eyeOffset - 5),
        Offset(center.dx + eyeOffset - 5, center.dy - eyeOffset - 5),
        eyebrowPaint,
      );
    } else if (mood == Mood.sad) {
      final rect = Rect.fromCircle(
        center: Offset(center.dx, center.dy + radius * 0.6),
        radius: radius * 0.6,
      );
      canvas.drawArc(rect, pi + 0.4, pi - 0.8, false, mouthPaint);

      // Add sad eyebrows
      final eyebrowPaint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;

      canvas.drawLine(
        Offset(center.dx - eyeOffset - 8, center.dy - eyeOffset - 3),
        Offset(center.dx - eyeOffset + 5, center.dy - eyeOffset - 8),
        eyebrowPaint,
      );
      canvas.drawLine(
        Offset(center.dx + eyeOffset + 8, center.dy - eyeOffset - 3),
        Offset(center.dx + eyeOffset - 5, center.dy - eyeOffset - 8),
        eyebrowPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant MoodFacePainter oldDelegate) {
    return oldDelegate.mood != mood || oldDelegate.color != color;
  }
}
