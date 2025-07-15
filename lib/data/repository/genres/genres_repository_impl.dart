import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/data/sources/genres/genres_firebase_service.dart';
import 'package:flutter_bloc_project/domain/repository/genres/genres.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class GenresRepositoryImpl extends GenresRepository {
  @override
  Future<Either> getGenres() => sl<GenresFirebaseService>().getGenres();

  @override
  Future<Either> getGenreById(String id) =>
      sl<GenresFirebaseService>().getGenre(id);
}
