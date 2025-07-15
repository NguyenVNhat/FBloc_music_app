import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/data/sources/song/song_firebase_service.dart';
import 'package:flutter_bloc_project/domain/entities/song/song.dart';
import 'package:flutter_bloc_project/domain/repository/song/song.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class SongRepositoryImpl extends SongsRepository {
  @override
  Future<Either> getSongs() async {
    return await sl<SongFireBaseService>().getSongs();
  }

  @override
  Future<Either> getSong(String id) async {
    return await sl<SongFireBaseService>().getSong(id);
  }

  @override
  Future<Either> addSong(SongEntity song) async {
    return await sl<SongFireBaseService>().addSong(song);
  }

  @override
  Future<Either> updateSong(SongEntity song) async {
    return await sl<SongFireBaseService>().updateSong(song);
  }

  @override
  Future<Either> deleteSong(String id) async {
    print('SongRepositoryImpl: Deleting song with ID: $id');
    final result = await sl<SongFireBaseService>().deleteSong(id);
    print('SongRepositoryImpl: Firebase service returned: $result');
    return result;
  }
}
