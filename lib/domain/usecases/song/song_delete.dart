import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/core/usecases/usecase.dart';
import 'package:flutter_bloc_project/domain/repository/song/song.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class SongDeleteUseCase implements UseCase<Either, String> {
  @override
  Future<Either> call({String? params}) async {
    print('SongDeleteUseCase: Calling delete with params: $params');
    final result = await sl<SongsRepository>().deleteSong(params!);
    print('SongDeleteUseCase: Repository returned: $result');
    return result;
  }
}
