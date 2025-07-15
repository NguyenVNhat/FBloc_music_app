import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/core/usecases/usecase.dart';
import 'package:flutter_bloc_project/domain/entities/banner/banner.dart';
import 'package:flutter_bloc_project/domain/repository/banner/banner.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class BannerUseCase extends UseCase<Either, BannerEntity> {
  @override
  Future<Either> call({dynamic params}) async {
    return sl<BannerRepository>().getBanners();
  }
}
