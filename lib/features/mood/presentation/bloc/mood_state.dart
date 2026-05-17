import 'package:equatable/equatable.dart';
import '../../domain/entities/mood_entry.dart';

abstract class MoodState extends Equatable {
  const MoodState();

  @override
  List<Object> get props => [];
}

class MoodInitial extends MoodState {}

class MoodLoading extends MoodState {}

class MoodLoaded extends MoodState {
  final List<MoodEntry> entries;

  const MoodLoaded(this.entries);

  @override
  List<Object> get props => [entries];
}

class MoodError extends MoodState {
  final String message;

  const MoodError(this.message);

  @override
  List<Object> get props => [message];
}
