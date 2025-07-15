import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_project/data/models/banner/banner.dart';
import 'package:flutter_bloc_project/domain/entities/banner/banner.dart';

abstract class BannerFirebaseService {
  Future<Either> getBanners();
}

class BannerFirebaseServiceImpl implements BannerFirebaseService {
  @override
  Future<Either> getBanners() async {
    try {
      List<BannerEntity> banners = [];
      final result =
          await FirebaseFirestore.instance.collection('banners').get();
      for (var e in result.docs) {
        final bannerModel = BannerModel.fromJson(e.data());
        banners.add(bannerModel.toEntity());
      }
      return Right(banners);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
