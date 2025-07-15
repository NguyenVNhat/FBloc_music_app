import 'package:flutter_bloc_project/domain/entities/banner/banner.dart';

abstract class BannersState {}

class BannersLoading extends BannersState {}

class BannersLoaded extends BannersState {
  final List<BannerEntity> banners;
  BannersLoaded({required this.banners});
}

class BannersError extends BannersState {
  final String message;
  BannersError({required this.message});
}

class BannersEmpty extends BannersState {}
