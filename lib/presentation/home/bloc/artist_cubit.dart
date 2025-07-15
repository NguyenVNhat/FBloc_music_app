import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/domain/usecases/artist/artist.dart';
import 'package:flutter_bloc_project/presentation/home/bloc/artist_state.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class ArtistCubit extends Cubit<ArtistState> {
  ArtistCubit() : super(ArtistInitial());
  Future<void> getArtists() async {
    emit(ArtistLoading());
    final result = await sl<ArtistUseCase>().call();
    result.fold(
      (error) => emit(ArtistError(error)),
      (data) => emit(ArtistLoaded(data)),
    );
  }
}
