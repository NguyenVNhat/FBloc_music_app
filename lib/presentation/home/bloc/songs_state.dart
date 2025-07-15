import 'package:flutter_bloc_project/domain/entities/song/song.dart';

abstract class SongsState {}

class SongsLoading extends SongsState {}

class SongsLoaded extends SongsState {
  final List<SongEntity> songs;
  SongsLoaded({required this.songs});
}

class SongsError extends SongsState {
  final String message;
  SongsError({required this.message});
}
