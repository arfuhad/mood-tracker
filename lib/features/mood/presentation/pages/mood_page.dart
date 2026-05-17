import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../../domain/entities/mood_entry.dart';
import '../bloc/mood_bloc.dart';
import '../bloc/mood_event.dart';
import '../bloc/mood_state.dart';
import '../widgets/mood_face.dart';
import '../widgets/timeline_entry_widget.dart';

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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Mood Tracker', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Text(
              'How are you feeling?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _MoodButton(mood: Mood.sad, label: 'Sad'),
                _MoodButton(mood: Mood.neutral, label: 'Neutral'),
                _MoodButton(mood: Mood.happy, label: 'Happy'),
              ],
            ),
            const Spacer(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Divider(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Past Entries',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              height: 160,
              child: _MoodTimeline(),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _MoodButton extends StatelessWidget {
  final Mood mood;
  final String label;

  const _MoodButton({required this.mood, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
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
          child: MoodFace(mood: mood, size: 80),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _MoodTimeline extends StatelessWidget {
  const _MoodTimeline();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoodBloc, MoodState>(
      builder: (context, state) {
        if (state is MoodLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MoodLoaded) {
          if (state.entries.isEmpty) {
            return const Center(child: Text('No entries yet. Log your first mood!'));
          }

          // Only show last 7 entries
          final entriesToShow = state.entries.take(7).toList();

          return ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            itemCount: entriesToShow.length,
            separatorBuilder: (context, index) => const SizedBox(width: 30),
            itemBuilder: (context, index) {
              return TimelineEntryWidget(entry: entriesToShow[index]);
            },
          );
        } else if (state is MoodError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox();
      },
    );
  }
}
