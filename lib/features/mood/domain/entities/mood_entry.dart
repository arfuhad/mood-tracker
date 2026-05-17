import 'package:equatable/equatable.dart';

enum Mood {
  happy,
  neutral,
  sad,
}

class MoodEntry extends Equatable {
  final DateTime date;
  final Mood mood;

  const MoodEntry({
    required this.date,
    required this.mood,
  });

  @override
  List<Object?> get props => [date, mood];
}
