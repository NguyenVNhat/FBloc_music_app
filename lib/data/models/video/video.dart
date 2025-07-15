import 'package:flutter_bloc_project/data/models/genres/genres.dart';
import 'package:flutter_bloc_project/domain/entities/video/video.dart';

class VideoModel {
  String? id;
  String? title;
  String? content;
  String? image;
  String? uri;
  List<GenresModel>? genres;

  VideoModel(
      {this.id, this.title, this.content, this.image, this.uri, this.genres});

  VideoModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    image = json['image'];
    uri = json['uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['content'] = content;
    data['image'] = image;
    data['uri'] = uri;
    if (genres != null) {
      data['genres'] = genres!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

extension VideoModel1X on VideoModel {
  VideoEntity toEntity() => VideoEntity(
        id: id ?? '',
        title: title ?? '',
        content: content ?? '',
        image: image ?? '',
        uri: uri ?? '',
        genres: genres?.map((e) => e.toEntity()).toList() ?? [],
      );
}
