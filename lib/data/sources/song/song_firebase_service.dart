import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/data/models/song/song.dart';
import 'package:flutter_bloc_project/domain/entities/song/song.dart';

abstract class SongFireBaseService {
  Future<Either> getSongs();
  Future<Either> getSong(String id);
  Future<Either> addSong(SongEntity song);
  Future<Either> updateSong(SongEntity song);
  Future<Either> deleteSong(String id);
}

class SongFireBaseServiceImpl implements SongFireBaseService {
  @override
  Future<Either> getSongs() async {
    try {
      List<SongEntity> songs = [];
      final data = await FirebaseFirestore.instance
          .collection('songs')
          .orderBy('releaseDate', descending: true)
          .get();
      for (var e in data.docs) {
        final songModel = SongModel.fromJson(e.data());
        songModel.id = e.id;
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> getSong(String id) async {
    try {
      final query =
          await FirebaseFirestore.instance.collection('songs').doc(id).get();

      if (query.data() == null) {
        return Left('Song not found');
      }

      final songModel = SongModel.fromJson(query.data()!);
      return Right(songModel.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> addSong(SongEntity song) async {
    try {
      final songModel = SongModel.fromEntity(song);
      final result = await FirebaseFirestore.instance
          .collection('songs')
          .add(songModel.toJson());
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> updateSong(SongEntity song) async {
    try {
      final songModel = SongModel.fromEntity(song);
      final query = await FirebaseFirestore.instance
          .collection('songs')
          .where('id', isEqualTo: song.id)
          .get();

      if (query.docs.isEmpty) {
        return Left('Song not found');
      }

      await query.docs.first.reference.update(songModel.toJson());
      return Right(song);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either> deleteSong(String id) async {
    try {
      print('Attempting to delete song with ID: $id');

      final query = await FirebaseFirestore.instance
          .collection('songs')
          .where('id', isEqualTo: id)
          .get();

      print('Found ${query.docs.length} documents with ID: $id');

      if (query.docs.isEmpty) {
        print('No song found with ID: $id');
        return Left('Song not found');
      }

      // Delete the first document found
      await query.docs.first.reference.delete();
      print('Successfully deleted song with ID: $id');

      return Right('Song deleted successfully');
    } catch (e) {
      print('Error deleting song: $e');
      return Left('Failed to delete song: ${e.toString()}');
    }
  }
}
