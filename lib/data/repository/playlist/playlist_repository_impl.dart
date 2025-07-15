import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/data/models/playlist/add_playlist_request.dart';
import 'package:flutter_bloc_project/data/sources/playlist/playlist_firebase_service.dart';
import 'package:flutter_bloc_project/domain/repository/playlist/playlist.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class PlaylistRepositoryImpl extends PlaylistRepository {
  @override
  Future<Either> addPlaylist(AddPlaylistRequest request) async {
    return await sl<PlaylistFirebaseService>().addPlaylist(request);
  }

  @override
  Future<Either> deletePlaylist(String playlistId) async {
    return await sl<PlaylistFirebaseService>().deletePlaylist(playlistId);
  }

  @override
  Future<Either> getPlaylists(String userId) async {
    return await sl<PlaylistFirebaseService>().getPlaylists(userId);
  }
}
