import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/data/sources/banner/banner_firebase_service.dart';
import 'package:flutter_bloc_project/domain/repository/banner/banner.dart';
import 'package:flutter_bloc_project/service_locator.dart';

class BannerRepositoryImpl extends BannerRepository {
  @override
  Future<Either> getBanners() async {
    return sl<BannerFirebaseService>().getBanners();
  }
}
