import 'package:flutter_bloc_project/domain/entities/video/video.dart';

abstract class VideoState {}

class VideoInitial extends VideoState {}

class VideoLoading extends VideoState {}

class VideoError extends VideoState {
  final String message;
  VideoError({required this.message});
}

class VideoLoaded extends VideoState {
  final List<VideoEntity> video;
  VideoLoaded({required this.video});
}
