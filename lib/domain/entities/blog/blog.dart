import 'package:cloud_firestore/cloud_firestore.dart';

class BlogEntity {
  final String id;
  final String avatar;
  final String content;
  final Timestamp createdAt;
  final String userName;
  final List<String> images;
  final String title;
  final String songId;

  BlogEntity({
    required this.id,
    required this.avatar,
    required this.content,
    required this.createdAt,
    required this.userName,
    required this.images,
    required this.title,
    required this.songId,
  });
}
