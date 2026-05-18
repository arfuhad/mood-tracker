import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/mood_bloc.dart';
import '../bloc/mood_state.dart';
import 'timeline_entry_widget.dart';

class MoodTimeline extends StatelessWidget {
  const MoodTimeline({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoodBloc, MoodState>(
      builder: (context, state) {
        if (state is MoodLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is MoodLoaded) {
          if (state.entries.isEmpty) {
            return const Center(
              child: Text(
                'No entries yet. Log your first mood!',
                style: TextStyle(color: Colors.grey),
              ),
            );
          }

          final entriesToShow = state.entries.take(7).toList();

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: entriesToShow.length,
            separatorBuilder: (context, index) => const SizedBox(width: 32),
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
