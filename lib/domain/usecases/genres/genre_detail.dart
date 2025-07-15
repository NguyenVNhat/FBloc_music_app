import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/core/usecases/usecase.dart';
import 'package:flutter_bloc_project/domain/repository/genres/genres.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class GenreDetailUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) {
    return sl.call<GenresRepository>().getGenreById(params);
  }
}
