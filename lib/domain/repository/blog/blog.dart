import 'package:dartz/dartz.dart';

abstract class BlogRepository {
  Future<Either> getBlogs();
}
