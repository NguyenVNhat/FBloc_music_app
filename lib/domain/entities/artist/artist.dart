import 'package:flutter_bloc_project/domain/entities/genres/genres.dart';

class ArtistEntity {
  final String id;
  final String name;
  final String avatar;
  final List<GenresEntity> genres;

  ArtistEntity(
      {required this.id,
      required this.name,
      required this.avatar,
      required this.genres});
}
