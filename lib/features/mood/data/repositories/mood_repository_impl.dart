import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/mood_entry.dart';
import '../../domain/repositories/mood_repository.dart';
import '../datasources/mood_local_data_source.dart';

class MoodRepositoryImpl implements MoodRepository {
  final MoodLocalDataSource localDataSource;

  MoodRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<MoodEntry>>> getMoodEntries() async {
    try {
      final entries = await localDataSource.getMoodEntries();
      return Right(entries);
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addMoodEntry(Mood mood) async {
    try {
      await localDataSource.addMoodEntry(mood);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure());
    }
  }
}
