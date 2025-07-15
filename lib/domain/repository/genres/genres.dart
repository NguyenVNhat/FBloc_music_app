import 'package:dartz/dartz.dart';

abstract class GenresRepository {
  Future<Either> getGenres();

  Future<Either> getGenreById(String id);
}
