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

  Color get _backgroundColor {
    switch (mood) {
      case Mood.happy:
        return const Color(0xFFE4DD9A); // Light yellow
      case Mood.neutral:
        return const Color(0xFFD3D3D3); // Light greyish blue
      case Mood.sad:
        return const Color(0xFF86A2C5); // Light blue
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _backgroundColor,
        borderRadius: BorderRadius.circular(size * 0.25),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: _backgroundColor.withValues(alpha: 0.6),
                  blurRadius: 15,
                  spreadRadius: 5,
                ),
              ]
            : null,
      ),
      padding: EdgeInsets.all(size * 0.15),
      child: CustomPaint(
        painter: MoodFacePainter(mood: mood, color: Colors.black),
      ),
    );
  }
}
