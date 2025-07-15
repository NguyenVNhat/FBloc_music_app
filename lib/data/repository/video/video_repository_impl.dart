import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/data/sources/video/video_firebase_service.dart';
import 'package:flutter_bloc_project/domain/repository/video/video.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class VideoRepositoryImpl extends VideoRepository {
  @override
  Future<Either> getVideos() {
    return sl<VideoFirebaseService>().getVideos();
  }

  @override
  Future<Either> getVideosWithGenres() {
    return sl<VideoFirebaseService>().getVideosWithGenres();
  }

  @override
  Future<Either> getVideo(String id) {
    return sl<VideoFirebaseService>().getVideo(id);
  }
}
