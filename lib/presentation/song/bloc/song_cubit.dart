import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/domain/usecases/song/song_detail.dart';
import 'package:flutter_bloc_project/presentation/song/bloc/song_state.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class SongCubit extends Cubit<SongState> {
  SongCubit() : super(SongInitial());

  Future<void> getSong(String id) async {
    emit(SongLoading());
    final result = await sl<SongDetailUseCase>().call(params: id);
    result.fold(
      (error) => emit(SongError(message: error)),
      (data) => emit(SongLoaded(song: data)),
    );
  }
}
