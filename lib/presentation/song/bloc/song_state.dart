import 'package:flutter_bloc_project/domain/entities/song/song.dart';

abstract class SongState {}

class SongInitial extends SongState {}

class SongLoading extends SongState {}

class SongLoaded extends SongState {
  final SongEntity song;

  SongLoaded({required this.song});
}

class SongError extends SongState {
  final String message;

  SongError({required this.message});
}
