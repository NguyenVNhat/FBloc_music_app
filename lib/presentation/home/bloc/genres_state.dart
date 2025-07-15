import 'package:flutter_bloc_project/domain/entities/genres/genres.dart';

abstract class GenresState {}

class GenresLoading extends GenresState {}

class GenresLoaded extends GenresState {
  final List<GenresEntity> genres;
  GenresLoaded(this.genres);
}

class GenresError extends GenresState {
  final String message;
  GenresError(this.message);
}
