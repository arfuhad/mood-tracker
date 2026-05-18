import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/mood_entry.dart';
import '../bloc/mood_bloc.dart';
import '../bloc/mood_event.dart';
import '../widgets/mood_button.dart';
import '../widgets/weekly_streak_card.dart';
import '../widgets/average_mood_card.dart';
import '../widgets/mood_timeline.dart';
import 'package:intl/intl.dart';

class MoodPage extends StatelessWidget {
  const MoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MoodBloc>()..add(LoadMoods()),
      child: const MoodView(),
    );
  }
}

class MoodView extends StatelessWidget {
  const MoodView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 32),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth > 800) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: MoodButton(
                                    mood: Mood.happy,
                                    label: 'Happy',
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: MoodButton(
                                    mood: Mood.neutral,
                                    label: 'Neutral',
                                  ),
                                ),
                                SizedBox(width: 16),
                                Expanded(
                                  child: MoodButton(
                                    mood: Mood.sad,
                                    label: 'Sad',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                const WeeklyStreakCard(),
                                const SizedBox(height: 16),
                                const AverageMoodCard(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: MoodButton(
                                  mood: Mood.happy,
                                  label: 'Happy',
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: MoodButton(
                                  mood: Mood.neutral,
                                  label: 'Neutral',
                                ),
                              ),
                              SizedBox(width: 12),
                              Expanded(
                                child: MoodButton(mood: Mood.sad, label: 'Sad'),
                              ),
                            ],
                          ),
                          SizedBox(height: 24),
                          WeeklyStreakCard(),
                          SizedBox(height: 16),
                          AverageMoodCard(),
                        ],
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 24),
              _buildPastEntries(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 40, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello there !! This is mood tracker application.',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'How are you feeling?',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1.5,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                DateFormat('MMMM d, yyyy').format(DateTime.now()),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                "${DateFormat('EEEE').format(DateTime.now())}, ${DateTime.now().hour < 12
                    ? 'Morning'
                    : DateTime.now().hour < 18
                    ? 'Afternoon'
                    : 'Evening'}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPastEntries() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.all(24),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Past 7 Entries',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'Scroll for more',
                style: TextStyle(fontSize: 12, color: Colors.grey[400]),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: Colors.grey[200]),
          const SizedBox(height: 24),
          const SizedBox(height: 120, child: MoodTimeline()),
        ],
      ),
    );
  }
}
