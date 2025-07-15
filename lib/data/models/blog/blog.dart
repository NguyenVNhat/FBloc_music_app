import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc_project/domain/entities/blog/blog.dart';

class BlogModel {
  String? id;
  String? avatar;
  String? content;
  Timestamp? createdAt;
  String? userName;
  List<String>? images;
  String? title;
  String? songId;

  BlogModel({
    this.id,
    this.avatar,
    this.content,
    this.createdAt,
    this.userName,
    this.images,
    this.title,
    this.songId,
  });

  BlogModel.fromJson(Map<String, dynamic> json) {
    if (json['id'] != null) {
      id = json['id'];
    }
    if (json['avatar'] != null) {
      avatar = json['avatar'];
    }
    if (json['content'] != null) {
      content = json['content'];
    }
    if (json['create_date'] != null) {
      createdAt = json['create_date'];
    }
    if (json['username'] != null) {
      userName = json['username'];
    }
    if (json['images'] != null) {
      images = json['images'].cast<String>();
    }
    if (json['title'] != null) {
      title = json['title'];
    }
    if (json['songId'] != null) {
      songId = json['songId'];
    }
  }
  static BlogModel fromEntity(BlogEntity entity) {
    return BlogModel(
      id: entity.id,
      avatar: entity.avatar,
      content: entity.content,
      createdAt: entity.createdAt,
      userName: entity.userName,
      images: entity.images,
      title: entity.title,
      songId: entity.songId,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) data['id'] = id;
    if (avatar != null) data['avatar'] = avatar;
    if (content != null) data['content'] = content;
    if (createdAt != null) data['create_date'] = createdAt;
    if (userName != null) data['username'] = userName;
    if (images != null) data['images'] = images;
    if (title != null) data['title'] = title;
    if (songId != null) data['songId'] = songId;
    return data;
  }
}

extension BlogModel1X on BlogModel {
  BlogEntity toEntity() {
    return BlogEntity(
      id: id ?? '',
      avatar: avatar ?? '',
      content: content ?? '',
      createdAt: createdAt ?? Timestamp.now(),
      userName: userName ?? '',
      images: images ?? [],
      title: title ?? '',
      songId: songId ?? '',
    );
  }
}
