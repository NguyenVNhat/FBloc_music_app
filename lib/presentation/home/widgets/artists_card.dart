import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/common/helpers/is_dark_mode.dart';
import 'package:flutter_bloc_project/core/config/theme/app_colors.dart';
import 'package:flutter_bloc_project/domain/entities/artist/artist.dart';
import 'package:flutter_bloc_project/presentation/home/bloc/artist_cubit.dart';
import 'package:flutter_bloc_project/presentation/home/bloc/artist_state.dart';
import 'package:flutter_bloc_project/presentation/home/pages/artist_detail_page.dart';
import 'package:shimmer/shimmer.dart';

class ArtistsCard extends StatelessWidget {
  const ArtistsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ArtistCubit()..getArtists(),
      child: BlocBuilder<ArtistCubit, ArtistState>(
        builder: (context, state) {
          if (state is ArtistLoading) {
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
          } else if (state is ArtistLoaded) {
            return ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: 14),
              scrollDirection: Axis.horizontal,
              itemCount: state.artists.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                ArtistEntity data = state.artists[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ArtistDetailPage(
                          artistName: data.name,
                          artistImage: data.avatar,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    margin: index == 0
                        ? const EdgeInsets.only(left: 12)
                        : index == state.artists.length - 1
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
                              image: NetworkImage(data.avatar),
                              fit: BoxFit.cover,
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
                                data.name,
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
