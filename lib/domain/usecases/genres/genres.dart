import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/core/usecases/usecase.dart';
import 'package:flutter_bloc_project/domain/entities/genres/genres.dart';
import 'package:flutter_bloc_project/domain/repository/genres/genres.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class GenresUseCase implements UseCase<Either, GenresEntity> {
  @override
  Future<Either> call({dynamic params}) {
    return sl<GenresRepository>().getGenres();
  }
}
