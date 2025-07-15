import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/common/helpers/is_dark_mode.dart';
import 'package:flutter_bloc_project/core/config/theme/app_colors.dart';
import 'package:flutter_bloc_project/core/config/theme/app_images.dart';
import 'package:flutter_bloc_project/domain/entities/song/song.dart';
import 'package:flutter_bloc_project/presentation/home/bloc/songs_cubit.dart';
import 'package:flutter_bloc_project/presentation/home/bloc/songs_state.dart';
import 'package:flutter_bloc_project/presentation/song/pages/song_detail_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class SongsCard extends StatelessWidget {
  const SongsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SongsCubit()..getSongs(),
      child: BlocBuilder<SongsCubit, SongsState>(
        builder: (context, state) {
          if (state is SongsLoading) {
            return Shimmer.fromColors(
              baseColor: Colors.grey.withValues(alpha: 0.1),
              highlightColor: Colors.grey.withValues(alpha: 0.3),
              child: ListView.separated(
                separatorBuilder: (context, index) => SizedBox(width: 14),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: index == 0
                        ? const EdgeInsets.only(left: 30)
                        : index == 2
                            ? const EdgeInsets.only(right: 30)
                            : EdgeInsets.zero,
                    child: Column(
                      spacing: 12,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 147,
                          height: 170,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          width: 147,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          width: 147,
                          height: 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else if (state is SongsLoaded) {
            return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: 14),
              scrollDirection: Axis.horizontal,
              itemCount: state.songs.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                SongEntity data = state.songs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => SongDetailPage(
                          songId: data.id,
                          image: data.image,
                          title: data.title,
                          artist: data.artist,
                          views: '1.2M Views',
                          date: '19 Nov 2015',
                          topSongs: [
                            {
                              'image': data.image,
                              'title': data.title,
                              'artist': data.artist,
                              'duration': '3:45',
                            },
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: index == 0
                        ? const EdgeInsets.only(left: 12)
                        : index == state.songs.length - 1
                            ? const EdgeInsets.only(right: 12)
                            : EdgeInsets.zero,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.grey.withValues(alpha: 0.4),
                        ),
                        borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 147,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(data.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            width: 147,
                            height: 200,
                            color: Colors.black.withValues(alpha: 0.3),
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SongDetailPage(
                                        songId: data.id,
                                        image: data.image,
                                        title: data.title,
                                        artist: data.artist,
                                        views: '1.2M Views',
                                        date: '19 Nov 2015',
                                        topSongs: [
                                          {
                                            'image': data.image,
                                            'title': data.title,
                                            'artist': data.artist,
                                            'duration': '3:45',
                                          },
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                icon: SvgPicture.asset(
                                  AppImages.iconTriangle,
                                  colorFilter: ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                  width: 29,
                                  height: 29,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 8),
                          width: 147,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data.title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: context.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
