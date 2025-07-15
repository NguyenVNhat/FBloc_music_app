import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/domain/entities/song/song.dart';

abstract class SongsRepository {
  Future<Either> getSongs();
  Future<Either> getSong(String id);
  Future<Either> addSong(SongEntity song);
  Future<Either> updateSong(SongEntity song);
  Future<Either> deleteSong(String id);
}
