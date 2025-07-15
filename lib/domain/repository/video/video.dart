import 'package:dartz/dartz.dart';

abstract class VideoRepository {
  Future<Either> getVideos();
  Future<Either> getVideosWithGenres();
  Future<Either> getVideo(String id);
}
