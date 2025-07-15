import 'package:flutter_bloc_project/domain/entities/genres/genres.dart';

class GenresModel {
  String? id;
  String? name;
  String? image;
  String? description;
  List<String>? tag;

  GenresModel({this.name, this.image, this.id, this.description, this.tag});

  GenresModel.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      name = json['name'];
      image = json['image'];
      description = json['description'];
      tag = [];
      for (var item in json['tag']) {
        tag?.add(item);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['image'] = image;
    data['description'] = description;
    data['tag'] = tag;
    return data;
  }
}

extension GenresModel1X on GenresModel {
  GenresEntity toEntity() => GenresEntity(
      name: name ?? '',
      image: image ?? '',
      id: id ?? '',
      tag: tag ?? [],
      description: description ?? '');
}
