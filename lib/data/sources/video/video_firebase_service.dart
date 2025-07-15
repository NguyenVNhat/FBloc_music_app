import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/data/models/genres/genres.dart';
import 'package:flutter_bloc_project/data/models/video/video.dart';
import 'package:flutter_bloc_project/domain/entities/video/video.dart';

abstract class VideoFirebaseService {
  Future<Either> getVideos();
  Future<Either> getVideosWithGenres();
  Future<Either> getVideo(String id);
}

class VideoFirebaseServiceImpl implements VideoFirebaseService {
  @override
  Future<Either> getVideos() async {
    try {
      List<VideoEntity> videos = [];
      final data = await FirebaseFirestore.instance.collection('videos').get();
      for (var e in data.docs) {
        final videoModel = VideoModel.fromJson(e.data());
        videoModel.id = e.id;
        videos.add(videoModel.toEntity());
      }
      return Right(videos);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> getVideosWithGenres() async {
    try {
      List<VideoEntity> videos = [];
      final data = await FirebaseFirestore.instance.collection('videos').get();
      for (var e in data.docs) {
        final videoModel = VideoModel.fromJson(e.data());
        videoModel.id = e.id;

        if (e.data()['genres'] == null) {
          videoModel.genres = [];
        } else {
          List<GenresModel> genres = [];
          for (var g in e.data()['genres']) {
            final genre = await FirebaseFirestore.instance
                .collection('genres')
                .doc(g)
                .get();
            final genreModel = GenresModel.fromJson(genre.data()!);
            genreModel.id = genre.id;
            genres.add(genreModel);
          }
          videoModel.genres = genres;
        }

        videos.add(videoModel.toEntity());
      }
      return Right(videos);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> getVideo(String id) async {
    try {
      final result =
          await FirebaseFirestore.instance.collection('videos').doc(id).get();
      if (result.data() == null) {
        return Left('Video not found');
      }
      final videoModel = VideoModel.fromJson(result.data()!);

      if (result.data()?['genres'] == null) {
        videoModel.genres = [];
      } else {
        List<GenresModel> genres = [];
        for (var g in result.data()?['genres']) {
          final genre = await FirebaseFirestore.instance
              .collection('genres')
              .doc(g)
              .get();
          final genreModel = GenresModel.fromJson(genre.data()!);
          genreModel.id = genre.id;
          genres.add(genreModel);
        }
        videoModel.genres = genres;
      }
      videoModel.id = result.id;
      return Right(videoModel.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
