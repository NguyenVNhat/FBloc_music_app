import 'package:flutter_bloc_project/domain/entities/blog/blog.dart';

abstract class BlogState {}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  List<BlogEntity> blogs;

  BlogLoaded({required this.blogs});
}

class BlogError extends BlogState {
  String message;

  BlogError({required this.message});
}
