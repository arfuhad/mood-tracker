import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/mood_entry.dart';
import 'mood_face.dart';

class TimelineEntryWidget extends StatefulWidget {
  final MoodEntry entry;

  const TimelineEntryWidget({super.key, required this.entry});

  @override
  State<TimelineEntryWidget> createState() => _TimelineEntryWidgetState();
}

class _TimelineEntryWidgetState extends State<TimelineEntryWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _animate() {
    _controller.forward().then((_) => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _animate,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DateFormat('MMM d').format(widget.entry.date).toUpperCase(),
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 12),
          ScaleTransition(
            scale: _scaleAnimation,
            child: MoodFace(mood: widget.entry.mood, size: 55),
          ),
          const SizedBox(height: 12),
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: _getMoodColor(widget.entry.mood),
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }

  Color _getMoodColor(Mood mood) {
    switch (mood) {
      case Mood.happy:
        return const Color(0xFFFFD54F); // Amber[300]
      case Mood.neutral:
        return const Color(0xFF90A4AE); // BlueGrey[300]
      case Mood.sad:
        return const Color(0xFF7986CB); // Indigo[300]
    }
  }
}
