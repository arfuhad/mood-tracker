import 'package:equatable/equatable.dart';
import '../../domain/entities/mood_entry.dart';

abstract class MoodEvent extends Equatable {
  const MoodEvent();

  @override
  List<Object> get props => [];
}

class LoadMoods extends MoodEvent {}

class AddMoodEvent extends MoodEvent {
  final Mood mood;

  const AddMoodEvent(this.mood);

  @override
  List<Object> get props => [mood];
}
