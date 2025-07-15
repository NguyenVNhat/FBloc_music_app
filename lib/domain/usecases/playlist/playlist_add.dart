import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/core/usecases/usecase.dart';
import 'package:flutter_bloc_project/domain/repository/playlist/playlist.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class PlaylistAddUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) {
    return sl<PlaylistRepository>().addPlaylist(params);
  }
}
