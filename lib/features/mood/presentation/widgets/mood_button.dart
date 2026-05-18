import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/mood_entry.dart';
import '../bloc/mood_bloc.dart';
import '../bloc/mood_event.dart';
import 'mood_face.dart';

class MoodButton extends StatelessWidget {
  final Mood mood;
  final String label;

  const MoodButton({super.key, required this.mood, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<MoodBloc>().add(AddMoodEvent(mood));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Logged $label mood!'),
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating,
            width: 200,
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MoodFace(mood: mood, size: 80),
            const SizedBox(height: 32),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
