import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/core/config/theme/app_colors.dart';
import 'package:flutter_bloc_project/presentation/home/bloc/banners_cubit.dart';
import 'package:flutter_bloc_project/presentation/home/bloc/banners_state.dart';

class BannerCarousel extends StatelessWidget {
  const BannerCarousel({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      child: BlocProvider(
        create: (_) => BannersCubit()..getBanners(),
        child: BlocBuilder<BannersCubit, BannersState>(
          builder: (context, state) {
            if (state is BannersLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is BannersLoaded) {
              return CarouselSlider(
                options: CarouselOptions(
                  height: 180,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 5),
                  viewportFraction: 0.9,
                  aspectRatio: 16 / 9,
                  enableInfiniteScroll: true,
                  enlargeCenterPage: true,
                  enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                  clipBehavior: Clip.hardEdge,
                ),
                items: state.banners.first.images.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                            color: AppColors.grey.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                                image: NetworkImage(i), fit: BoxFit.cover)),
                      );
                    },
                  );
                }).toList(),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
