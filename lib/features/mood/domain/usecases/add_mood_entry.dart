import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/mood_entry.dart';
import '../repositories/mood_repository.dart';

class AddMoodEntry implements UseCase<void, Mood> {
  final MoodRepository repository;

  AddMoodEntry(this.repository);

  @override
  Future<Either<Failure, void>> call(Mood mood) async {
    return await repository.addMoodEntry(mood);
  }
}
