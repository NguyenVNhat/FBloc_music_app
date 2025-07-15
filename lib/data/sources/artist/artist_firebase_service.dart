import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/data/models/artist/artist.dart';
import 'package:flutter_bloc_project/data/models/genres/genres.dart';
import 'package:flutter_bloc_project/domain/entities/artist/artist.dart';

abstract class ArtistFirebaseService {
  Future<Either> getArtists();
  Future<Either> getArtistsWithGenres();
}

class ArtistFirebaseServiceImpl implements ArtistFirebaseService {
  @override
  Future<Either> getArtists() async {
    try {
      List<ArtistEntity> artists = [];
      final data = await FirebaseFirestore.instance.collection('artists').get();
      for (var e in data.docs) {
        final artistModel = ArtistModel.fromJson(e.data());

        artists.add(artistModel.toEntity());
      }
      return Right(artists);
    } catch (e) {
      return Left(e);
    }
  }

  @override
  Future<Either> getArtistsWithGenres() async {
    try {
      List<ArtistEntity> artists = [];
      final data = await FirebaseFirestore.instance.collection('artists').get();
      for (var e in data.docs) {
        final artistModel = ArtistModel.fromJson(e.data());
        if (artistModel.genres == null) {
          artistModel.genres = [];
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
          artistModel.genres = genres;
        }

        artistModel.id = e.id;
        artists.add(artistModel.toEntity());
      }
      return Right(artists);
    } catch (e) {
      return Left(e);
    }
  }
}
