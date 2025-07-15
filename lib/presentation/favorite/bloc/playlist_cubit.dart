import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/data/models/playlist/add_playlist_request.dart';
import 'package:flutter_bloc_project/domain/usecases/playlist/playlist.dart';
import 'package:flutter_bloc_project/domain/usecases/playlist/playlist_add.dart';
import 'package:flutter_bloc_project/domain/usecases/playlist/playlist_delete.dart';
import 'package:flutter_bloc_project/presentation/favorite/bloc/playlist_state.dart';
import 'package:flutter_bloc_project/service_locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  PlaylistCubit() : super(PlaylistInitial());
  Future<void> getPlaylists() async {
    emit(PlaylistLoading());
    final userId = sl<SharedPreferences>().getString('userId');
    final result = await sl<PlaylistUseCase>().call(params: userId);
    result.fold((l) => emit(PlaylistError(message: l.message)),
        (r) => emit(PlaylistLoaded(songs: r)));
  }

  Future<void> addPlaylist(String songId) async {
    emit(PlaylistLoading());
    final userId = sl<SharedPreferences>().getString('userId');
    final result = await sl<PlaylistAddUseCase>().call(
        params: AddPlaylistRequest(
      songId: songId,
      IdUser: userId,
    ));
    result.fold((l) => emit(PlaylistError(message: l.message)),
        (r) => emit(PlaylistAdded(message: r)));
  }

  Future<void> deletePlaylist(String songId) async {
    emit(PlaylistLoading());
    final result = await sl<PlaylistDeleteUseCase>().call(params: songId);
    result.fold((l) => emit(PlaylistError(message: l.message)),
        (r) => emit(PlaylistDeleted(message: r)));
  }
}
