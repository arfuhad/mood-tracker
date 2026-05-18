import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/mood_bloc.dart';
import '../bloc/mood_state.dart';

class DaysStreakCard extends StatelessWidget {
  const DaysStreakCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoodBloc, MoodState>(
      builder: (context, state) {
        int streak = 0;

        if (state is MoodLoaded && state.entries.isNotEmpty) {
          Set<DateTime> uniqueDates = {};
          for (var entry in state.entries) {
            uniqueDates.add(
              DateTime(entry.date.year, entry.date.month, entry.date.day),
            );
          }

          List<DateTime> sortedDates = uniqueDates.toList()
            ..sort((a, b) => b.compareTo(a));

          streak = 1;
          DateTime currentDate = sortedDates.first;

          DateTime today = DateTime(
            DateTime.now().year,
            DateTime.now().month,
            DateTime.now().day,
          );
          int differenceInDays = today.difference(currentDate).inDays;

          if (differenceInDays > 1) {
            streak = 0;
          } else {
            for (int i = 1; i < sortedDates.length; i++) {
              if (currentDate.difference(sortedDates[i]).inDays == 1) {
                streak++;
                currentDate = sortedDates[i];
              } else {
                break;
              }
            }
          }
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: const Color(0xFF1E1E1E),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'DAYS STREAK',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '$streak',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 52,
                  fontWeight: FontWeight.w800,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Days logging in a row',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        );
      },
    );
  }
}
