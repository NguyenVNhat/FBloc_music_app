import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/data/sources/artist/artist_firebase_service.dart';
import 'package:flutter_bloc_project/domain/repository/artist/artist.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class ArtistRepositoryImpl extends ArtistRepository {
  @override
  Future<Either> getArtists() {
    return sl<ArtistFirebaseService>().getArtists();
  }
}
