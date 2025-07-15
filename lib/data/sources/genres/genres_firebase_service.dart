import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/data/models/genres/genres.dart';
import 'package:flutter_bloc_project/domain/entities/genres/genres.dart';

abstract class GenresFirebaseService {
  Future<Either> getGenres();
  Future<Either> getGenre(String id);
}

class GenresFirebaseServiceImpl implements GenresFirebaseService {
  @override
  Future<Either> getGenres() async {
    try {
      List<GenresEntity> genres = [];
      final result =
          await FirebaseFirestore.instance.collection('genres').get();
      for (var e in result.docs) {
        final genresModel = GenresModel.fromJson(e.data());
        genresModel.id = e.id;
        genres.add(genresModel.toEntity());
      }
      return Right(genres);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> getGenre(String id) async {
    try {
      final result =
          await FirebaseFirestore.instance.collection('genres').doc(id).get();
      if (result.data() == null) {
        return Left('Genre not found');
      }
      final genresModel = GenresModel.fromJson(result.data()!);
      genresModel.id = result.id;
      return Right(genresModel.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }
}
