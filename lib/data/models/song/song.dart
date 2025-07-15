import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc_project/domain/entities/song/song.dart';

class SongModel {
  String? title;
  String? artist;
  num? duration;
  Timestamp? releaseDate;
  String? image;
  String? id;
  String? uri;

  SongModel({
    this.title,
    this.artist,
    this.duration,
    this.releaseDate,
    this.image,
    this.id,
    this.uri,
  });
  static SongModel fromJson(Map<String, dynamic> json) {
    return SongModel(
      title: json['title'],
      artist: json['artist'],
      duration: json['duration'],
      releaseDate: json['releaseDate'],
      image: json['image'],
      uri: json['uri'],
    );
  }

  static SongModel fromEntity(SongEntity entity) {
    return SongModel(
      title: entity.title,
      artist: entity.artist,
      duration: entity.duration,
      releaseDate: entity.releaseDate,
      image: entity.image,
      id: entity.id,
      uri: entity.uri,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artist': artist,
      'duration': duration,
      'releaseDate': releaseDate,
      'image': image,
      'id': id,
      'uri': uri,
    };
  }
}

extension SongModel1X on SongModel {
  SongEntity toEntity() => SongEntity(
        title: title ?? '',
        artist: artist ?? '',
        duration: duration ?? 0,
        releaseDate: releaseDate ?? Timestamp.now(),
        image: image ?? '',
        id: id ?? '',
        uri: uri ?? '',
      );
}
