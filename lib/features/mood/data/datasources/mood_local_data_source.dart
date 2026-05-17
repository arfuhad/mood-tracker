import '../../domain/entities/mood_entry.dart';

abstract class MoodLocalDataSource {
  Future<List<MoodEntry>> getMoodEntries();
  Future<void> addMoodEntry(Mood mood);
}

class MoodLocalDataSourceImpl implements MoodLocalDataSource {
  final List<MoodEntry> _entries = [];

  @override
  Future<List<MoodEntry>> getMoodEntries() async {
    // Return sorted entries, newest first
    final sorted = List<MoodEntry>.from(_entries);
    sorted.sort((a, b) => b.date.compareTo(a.date));
    return sorted;
  }

  @override
  Future<void> addMoodEntry(Mood mood) async {
    _entries.add(MoodEntry(date: DateTime.now(), mood: mood));
  }
}
