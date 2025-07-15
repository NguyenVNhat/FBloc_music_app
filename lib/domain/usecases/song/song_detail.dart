import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/core/usecases/usecase.dart';
import 'package:flutter_bloc_project/domain/repository/song/song.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class SongDetailUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) {
    return sl<SongsRepository>().getSong(params);
  }
}
