import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/add_mood_entry.dart';
import '../../domain/usecases/get_mood_entries.dart';
import 'mood_event.dart';
import 'mood_state.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  final GetMoodEntries getMoodEntries;
  final AddMoodEntry addMoodEntry;

  MoodBloc({
    required this.getMoodEntries,
    required this.addMoodEntry,
  }) : super(MoodInitial()) {
    on<LoadMoods>(_onLoadMoods);
    on<AddMoodEvent>(_onAddMoodEvent);
  }

  Future<void> _onLoadMoods(LoadMoods event, Emitter<MoodState> emit) async {
    emit(MoodLoading());
    final result = await getMoodEntries(NoParams());
    result.fold(
      (failure) => emit(const MoodError('Failed to load moods')),
      (entries) => emit(MoodLoaded(entries)),
    );
  }

  Future<void> _onAddMoodEvent(AddMoodEvent event, Emitter<MoodState> emit) async {
    final result = await addMoodEntry(event.mood);
    result.fold(
      (failure) => emit(const MoodError('Failed to add mood')),
      (_) => add(LoadMoods()),
    );
  }
}
