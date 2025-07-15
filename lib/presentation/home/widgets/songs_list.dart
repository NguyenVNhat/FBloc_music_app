import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/common/helpers/is_dark_mode.dart';
import 'package:flutter_bloc_project/core/config/theme/app_colors.dart';
import 'package:flutter_bloc_project/core/config/theme/app_images.dart';
import 'package:flutter_bloc_project/presentation/home/bloc/songs_cubit.dart';
import 'package:flutter_bloc_project/presentation/home/bloc/songs_state.dart';
import 'package:flutter_bloc_project/presentation/song/pages/song_detail_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SongsList extends StatelessWidget {
  const SongsList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SongsCubit()..getSongs(),
      child: BlocBuilder<SongsCubit, SongsState>(
        builder: (context, state) {
          if (state is SongsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SongsLoaded) {
            return Column(
              spacing: 16,
              children: state.songs.map(
                (e) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => SongDetailPage(
                            songId: e.id,
                            image: e.image,
                            title: e.title,
                            artist: e.artist,
                            views: '1.2M Views',
                            date: '19 Nov 2015',
                            topSongs: [
                              {
                                'image': e.image,
                                'title': e.title,
                                'artist': e.artist,
                                'duration': '3:45',
                              },
                              // ... add more mock songs if needed
                            ],
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 12, right: 12),
                      padding: EdgeInsets.only(
                        bottom: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: context.isDarkMode
                                ? Colors.white.withValues(alpha: 0.1)
                                : Colors.black.withValues(alpha: 0.1),
                          ),
                        ),
                      ),
                      child: Row(
                        spacing: 12,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.grey,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(100),
                                topRight: Radius.circular(100),
                                bottomLeft: Radius.circular(100),
                                bottomRight: Radius.circular(12),
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(e.image),
                                  fit: BoxFit.cover),
                            ),
                            child: Center(
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: Center(
                                  child:
                                      SvgPicture.asset(AppImages.iconTriangle),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              spacing: 4,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  e.title,
                                  style: TextStyle(
                                      color: context.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  e.artist,
                                  style: TextStyle(
                                      color: context.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(
                              AppImages.iconHeart,
                              height: 18,
                              width: 18,
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
            );
          }
          return Container();
        },
      ),
    );
  }
}
