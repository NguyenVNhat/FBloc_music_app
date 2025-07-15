import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/domain/entities/song/song.dart';
import 'package:flutter_bloc_project/domain/usecases/song/song.dart';
import 'package:flutter_bloc_project/domain/usecases/song/song_add.dart';
import 'package:flutter_bloc_project/domain/usecases/song/song_delete.dart';
import 'package:flutter_bloc_project/domain/usecases/song/song_update.dart';
import 'package:flutter_bloc_project/presentation/home/bloc/songs_state.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class SongsCubit extends Cubit<SongsState> {
  SongsCubit() : super(SongsLoading());

  Future<void> getSongs() async {
    emit(SongsLoading());
    final result = await sl<SongUseCase>().call();
    result.fold(
      (error) => emit(SongsError(message: error)),
      (data) => emit(SongsLoaded(songs: data)),
    );
  }

  Future<void> addSong(SongEntity song) async {
    emit(SongsLoading());
    final result = await sl<SongAddUseCase>().call(params: song);
    result.fold(
      (error) => emit(SongsError(message: error)),
      (data) {
        // After successful add, refresh the songs list
        getSongs();
      },
    );
  }

  Future<void> updateSong(SongEntity song) async {
    emit(SongsLoading());
    final result = await sl<SongUpdateUseCase>().call(params: song);
    result.fold(
      (error) => emit(SongsError(message: error)),
      (data) {
        // After successful update, refresh the songs list
        getSongs();
      },
    );
  }

  Future<void> deleteSong(String id) async {
    print('SongsCubit: Starting delete operation for ID: $id');
    emit(SongsLoading());
    final result = await sl<SongDeleteUseCase>().call(params: id);
    result.fold(
      (error) {
        print('SongsCubit: Delete failed with error: $error');
        emit(SongsError(message: error));
      },
      (data) {
        print('SongsCubit: Delete successful, refreshing songs list');
        // After successful delete, refresh the songs list
        getSongs();
      },
    );
  }
}
