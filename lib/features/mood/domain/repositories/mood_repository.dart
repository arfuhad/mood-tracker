import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/mood_entry.dart';

abstract class MoodRepository {
  Future<Either<Failure, List<MoodEntry>>> getMoodEntries();
  Future<Either<Failure, void>> addMoodEntry(Mood mood);
}
