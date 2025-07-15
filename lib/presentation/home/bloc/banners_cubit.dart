import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/domain/usecases/banner/banner.dart';
import 'package:flutter_bloc_project/presentation/home/bloc/banners_state.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class BannersCubit extends Cubit<BannersState> {
  BannersCubit() : super(BannersLoading());

  Future<void> getBanners() async {
    emit(BannersLoading());
    final result = await sl<BannerUseCase>().call();
    result.fold((error) => emit(BannersError(message: error)),
        (data) => emit(BannersLoaded(banners: data)));
  }
}
