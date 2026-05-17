import 'package:get_it/get_it.dart';
import 'features/mood/data/datasources/mood_local_data_source.dart';
import 'features/mood/data/repositories/mood_repository_impl.dart';
import 'features/mood/domain/repositories/mood_repository.dart';
import 'features/mood/domain/usecases/add_mood_entry.dart';
import 'features/mood/domain/usecases/get_mood_entries.dart';
import 'features/mood/presentation/bloc/mood_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Mood
  // Bloc
  sl.registerFactory(
    () => MoodBloc(
      getMoodEntries: sl(),
      addMoodEntry: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetMoodEntries(sl()));
  sl.registerLazySingleton(() => AddMoodEntry(sl()));

  // Repository
  sl.registerLazySingleton<MoodRepository>(
    () => MoodRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<MoodLocalDataSource>(
    () => MoodLocalDataSourceImpl(),
  );

  //! Core

  //! External
}
