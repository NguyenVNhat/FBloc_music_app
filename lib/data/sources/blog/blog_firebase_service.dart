import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/data/models/blog/blog.dart';
import 'package:flutter_bloc_project/domain/entities/blog/blog.dart';

abstract class BlogFirebaseService {
  Future<Either> getBlogs();
}

class BlogFireBaseServiceImpl implements BlogFirebaseService {
  @override
  Future<Either> getBlogs() async {
    try {
      List<BlogEntity> blogs = [];
      final data = await FirebaseFirestore.instance
          .collection('blogs')
          .orderBy('create_date', descending: true)
          .get();
      for (var e in data.docs) {
        final blogModel = BlogModel.fromJson(e.data());
        blogs.add(blogModel.toEntity());
      }
      return Right(blogs);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
