import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/mood_entry.dart';
import '../bloc/mood_bloc.dart';
import '../bloc/mood_state.dart';

class AverageMoodCard extends StatelessWidget {
  const AverageMoodCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoodBloc, MoodState>(
      builder: (context, state) {
        String moodText = '-';
        IconData moodIcon = Icons.remove;

        if (state is MoodLoaded && state.entries.isNotEmpty) {
          double total = 0;
          for (var entry in state.entries) {
            if (entry.mood == Mood.happy) total += 2;
            if (entry.mood == Mood.neutral) total += 1;
            if (entry.mood == Mood.sad) total -= 1;
          }

          double avg = total / state.entries.length;
          if (avg >= 1.5) {
            moodText = 'Good';
            moodIcon = Icons.arrow_upward;
          } else if (avg <= 0.5) {
            moodText = 'Low';
            moodIcon = Icons.arrow_downward;
          } else {
            moodText = 'Steady';
            moodIcon = Icons.remove;
          }
        } else if (state is MoodLoaded && state.entries.isEmpty) {
          moodText = 'No Data';
          moodIcon = Icons.horizontal_rule;
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE8E8E8),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'AVERAGE MOOD (from last 7 entries)',
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    moodText,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(moodIcon, color: Colors.black, size: 20),
              ),
            ],
          ),
        );
      },
    );
  }
}
