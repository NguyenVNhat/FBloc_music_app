import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/domain/usecases/video/video.dart';
import 'package:flutter_bloc_project/presentation/home/bloc/video_state.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class VideoCubit extends Cubit<VideoState> {
  VideoCubit() : super(VideoInitial());
  Future<void> getVideos() async {
    emit(VideoLoading());
    final result = await sl<VideoUseCase>().call();
    result.fold(
      (error) => emit(VideoError(message: error)),
      (data) => emit(VideoLoaded(video: data)),
    );
  }
}
