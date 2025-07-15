import 'package:flutter_bloc_project/domain/entities/genres/genres.dart';

class VideoEntity {
  final String id;
  final String title;
  final String content;
  final String image;
  final String uri;
  final List<GenresEntity> genres;

  VideoEntity({
    required this.id,
    required this.title,
    required this.content,
    required this.image,
    required this.uri,
    required this.genres,
  });
}
