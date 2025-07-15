import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/domain/usecases/genres/genre_detail.dart';
import 'package:flutter_bloc_project/domain/usecases/genres/genres.dart';
import 'package:flutter_bloc_project/presentation/home/bloc/genres_state.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class GenresCubit extends Cubit<GenresState> {
  GenresCubit() : super(GenresLoading());
  Future<void> getGenres() async {
    emit(GenresLoading());
    final result = await sl<GenresUseCase>().call();
    result.fold(
      (error) => emit(GenresError(error)),
      (data) => emit(GenresLoaded(data)),
    );
  }

  Future<void> getGenre(String id) async {
    emit(GenresLoading());
    final result = await sl<GenreDetailUseCase>().call(params: id);
    result.fold(
      (error) => emit(GenresError(error)),
      (data) => emit(GenresLoaded([data])),
    );
  }
}
