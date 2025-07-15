import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/data/sources/blog/blog_firebase_service.dart';
import 'package:flutter_bloc_project/domain/repository/blog/blog.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class BlogRepositoryImpl extends BlogRepository {
  @override
  Future<Either> getBlogs() async {
    return await sl<BlogFirebaseService>().getBlogs();
  }
}
