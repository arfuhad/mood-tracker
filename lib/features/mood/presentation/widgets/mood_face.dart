import 'package:flutter/material.dart';
import '../../domain/entities/mood_entry.dart';
import 'mood_face_painter.dart';

class MoodFace extends StatelessWidget {
  final Mood mood;
  final double size;
  final bool isSelected;

  const MoodFace({
    super.key,
    required this.mood,
    this.size = 100,
    this.isSelected = false,
  });

  Color get _moodColor {
    switch (mood) {
      case Mood.happy:
        return Colors.green;
      case Mood.neutral:
        return Colors.grey;
      case Mood.sad:
        return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: isSelected
          ? BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: _moodColor.withValues(alpha: 0.4),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ],
            )
          : null,
      child: CustomPaint(
        painter: MoodFacePainter(mood: mood, color: _moodColor),
      ),
    );
  }
}
