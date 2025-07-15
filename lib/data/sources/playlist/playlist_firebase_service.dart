import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/data/models/playlist/add_playlist_request.dart';
import 'package:flutter_bloc_project/data/models/song/song.dart';
import 'package:flutter_bloc_project/data/sources/song/song_firebase_service.dart';
import 'package:flutter_bloc_project/domain/entities/song/song.dart';
import 'package:flutter_bloc_project/service_locator.dart';

abstract class PlaylistFirebaseService {
  Future<Either> getPlaylists(String userId);
  Future<Either> addPlaylist(AddPlaylistRequest request);
  Future<Either> deletePlaylist(String playlistId);
}

class PlaylistFirebaseServiceImpl implements PlaylistFirebaseService {
  @override
  Future<Either> getPlaylists(String userId) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('playlist')
          .where('idUser', isEqualTo: userId)
          .get();
      if (result.docs.isEmpty) {
        return Left("No playlists found for this user.");
      }
      List<SongEntity> playlists = [];
      for (var doc in result.docs) {
        sl<SongFireBaseService>().getSong(doc['idSong']).then((songResult) {
          songResult.fold(
            (l) => playlists.add(SongModel.fromJson(l).toEntity()),
            (r) => playlists.add(r),
          );
        });
      }
      return Right(playlists);
    } catch (e) {
      return Left("Error fetching playlists: $e");
    }
  }

  @override
  Future<Either> addPlaylist(AddPlaylistRequest request) async {
    try {
      await FirebaseFirestore.instance
          .collection('playlist')
          .add(request.toJson());
      return Right("Playlist added successfully");
    } catch (e) {
      return Left("Error adding playlist: $e");
    }
  }

  @override
  Future<Either> deletePlaylist(String playlistId) async {
    try {
      await FirebaseFirestore.instance
          .collection('playlist')
          .doc(playlistId)
          .delete();
      return Right("Playlist deleted successfully");
    } catch (e) {
      return Left("Error deleting playlist: $e");
    }
  }
}
