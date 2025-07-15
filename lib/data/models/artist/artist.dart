import 'package:flutter_bloc_project/data/models/genres/genres.dart';
import 'package:flutter_bloc_project/domain/entities/artist/artist.dart';

class ArtistModel {
  String? id;
  String? name;
  String? avatar;
  List<GenresModel>? genres;

  ArtistModel({this.id, this.name, this.avatar, this.genres});

  ArtistModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['avatar'] = avatar;
    if (genres != null) {
      data['genres'] = genres!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

extension ArtistModel1X on ArtistModel {
  ArtistEntity toEntity() => ArtistEntity(
      name: name ?? '',
      avatar: avatar ?? '',
      id: id ?? '',
      genres: genres?.map((e) => e.toEntity()).toList() ?? []);
}
