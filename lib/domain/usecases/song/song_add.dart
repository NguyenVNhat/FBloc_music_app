import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/core/usecases/usecase.dart';
import 'package:flutter_bloc_project/domain/entities/song/song.dart';
import 'package:flutter_bloc_project/domain/repository/song/song.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class SongAddUseCase implements UseCase<Either, SongEntity> {
  @override
  Future<Either> call({SongEntity? params}) async {
    return sl<SongsRepository>().addSong(params!);
  }
}
