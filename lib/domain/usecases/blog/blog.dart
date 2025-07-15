import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/core/usecases/usecase.dart';
import 'package:flutter_bloc_project/domain/entities/blog/blog.dart';
import 'package:flutter_bloc_project/domain/repository/blog/blog.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class BlogUseCase implements UseCase<Either, BlogEntity> {
  @override
  Future<Either> call({dynamic params}) async {
    return sl<BlogRepository>().getBlogs();
  }
}
