import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/core/usecases/usecase.dart';
import 'package:flutter_bloc_project/domain/repository/song/song.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class SongUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic params}) async {
    return sl<SongsRepository>().getSongs();
  }
}
