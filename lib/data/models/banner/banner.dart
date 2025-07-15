import 'package:flutter_bloc_project/domain/entities/banner/banner.dart';

class BannerModel {
  List<String>? images;

  BannerModel({this.images});

  BannerModel.fromJson(Map<String, dynamic> json) {
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['images'] = images;
    return data;
  }
}

extension BannerModel1X on BannerModel {
  BannerEntity toEntity() => BannerEntity(images: images ?? []);
}
