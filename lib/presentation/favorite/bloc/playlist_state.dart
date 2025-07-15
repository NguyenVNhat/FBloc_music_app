import 'package:flutter_bloc_project/domain/entities/song/song.dart';

abstract class PlaylistState {}

class PlaylistInitial extends PlaylistState {}

class PlaylistLoading extends PlaylistState {}

class PlaylistLoaded extends PlaylistState {
  final List<SongEntity> songs;
  PlaylistLoaded({required this.songs});
}

class PlaylistAdded extends PlaylistState {
  final String message;
  PlaylistAdded({required this.message});
}

class PlaylistDeleted extends PlaylistState {
  final String message;
  PlaylistDeleted({required this.message});
}

class PlaylistError extends PlaylistState {
  final String message;
  PlaylistError({required this.message});
}
