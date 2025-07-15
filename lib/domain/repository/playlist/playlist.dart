import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/data/models/playlist/add_playlist_request.dart';

abstract class PlaylistRepository {
  Future<Either> getPlaylists(String userId);
  Future<Either> addPlaylist(AddPlaylistRequest request);
  Future<Either> deletePlaylist(String playlistId);
}
