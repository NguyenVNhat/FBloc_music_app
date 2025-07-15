import 'package:flutter_bloc_project/domain/entities/artist/artist.dart';

abstract class ArtistState {}

class ArtistInitial extends ArtistState {}

class ArtistLoading extends ArtistState {}

class ArtistLoaded extends ArtistState {
  final List<ArtistEntity> artists;

  ArtistLoaded(this.artists);
}

class ArtistError extends ArtistState {
  final String message;

  ArtistError(
    this.message,
  );
}
