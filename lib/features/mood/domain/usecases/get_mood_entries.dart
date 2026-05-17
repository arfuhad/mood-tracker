import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/mood_entry.dart';
import '../repositories/mood_repository.dart';

class GetMoodEntries implements UseCase<List<MoodEntry>, NoParams> {
  final MoodRepository repository;

  GetMoodEntries(this.repository);

  @override
  Future<Either<Failure, List<MoodEntry>>> call(NoParams params) async {
    return await repository.getMoodEntries();
  }
}
