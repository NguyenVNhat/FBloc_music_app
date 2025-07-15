import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/domain/usecases/blog/blog.dart';
import 'package:flutter_bloc_project/presentation/blog/bloc/blog_state.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class BlogCubit extends Cubit<BlogState> {
  BlogCubit() : super(BlogInitial());
  Future<void> getBlogs() async {
    emit(BlogLoading());
    final result = await sl<BlogUseCase>().call();
    result.fold(
      (error) => emit(BlogError(message: error)),
      (data) => emit(BlogLoaded(blogs: data)),
    );
  }
}
