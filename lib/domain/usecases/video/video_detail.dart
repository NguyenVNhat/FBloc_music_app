import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/core/usecases/usecase.dart';
import 'package:flutter_bloc_project/domain/repository/video/video.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class VideoDetailUseCase extends UseCase<Either, dynamic> {
  @override
  Future<Either> call({dynamic params}) {
    return sl<VideoRepository>().getVideo(params);
  }
}
