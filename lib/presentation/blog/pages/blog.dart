import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/common/helpers/is_dark_mode.dart';
import 'package:flutter_bloc_project/core/config/theme/app_colors.dart';
import 'package:flutter_bloc_project/core/config/theme/app_images.dart';
import 'package:flutter_bloc_project/presentation/blog/bloc/blog_cubit.dart';
import 'package:flutter_bloc_project/presentation/blog/bloc/blog_state.dart';
import 'package:flutter_bloc_project/presentation/song/pages/song_detail_page.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:timeago/timeago.dart' as timeago;

class BlogPage extends StatefulWidget {
  const BlogPage({Key? key}) : super(key: key);

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> with TickerProviderStateMixin {
  late AnimationController _rotationController;
  Set<int> expandedPostIndexes = {};
  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    _rotationController.repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BlogCubit()..getBlogs(),
      child: BlocBuilder<BlogCubit, BlogState>(
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is BlogLoaded) {
            final posts = state.blogs;
            return Scaffold(
              backgroundColor: context.isDarkMode
                  ? AppColors.darkBackground
                  : AppColors.lightBackground,
              appBar: AppBar(
                backgroundColor: context.isDarkMode
                    ? AppColors.darkBackground
                    : AppColors.lightBackground,
                elevation: 0,
                title: Text(
                  'Music Blog',
                  style: TextStyle(
                      color: context.isDarkMode
                          ? AppColors.lightBackground
                          : AppColors.darkBackground),
                ),
                iconTheme: IconThemeData(
                    color: context.isDarkMode
                        ? AppColors.lightBackground
                        : AppColors.darkBackground),
              ),
              body: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  final isExpanded = expandedPostIndexes.contains(index);
                  return Card(
                    color: Colors.transparent,
                    elevation: 2,
                    shadowColor: Colors.transparent,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(post.avatar),
                              radius: 22,
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.userName,
                                  style: TextStyle(
                                      color: context.isDarkMode
                                          ? AppColors.lightBackground
                                          : AppColors.darkGrey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                Text(
                                  timeago.format(
                                      DateTime.fromMillisecondsSinceEpoch(post
                                          .createdAt.millisecondsSinceEpoch)),
                                  style: TextStyle(
                                      color: context.isDarkMode
                                          ? AppColors.lightBackground
                                          : AppColors.darkGrey,
                                      fontSize: 12),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          post.title,
                          style: TextStyle(
                              color: context.isDarkMode
                                  ? AppColors.lightBackground
                                  : AppColors.darkGrey,
                              fontSize: 15),
                        ),
                        if (post.images.isNotEmpty)
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 12),
                            width: double.infinity,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                spacing: 8,
                                mainAxisSize: MainAxisSize.min,
                                children: post.images
                                    .map(
                                      (e) => Container(
                                        width: post.images.length > 1
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .6
                                            : MediaQuery.of(context).size.width,
                                        height: 180,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(e),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        Row(
                          spacing: 12,
                          children: [
                            RotationTransition(
                              turns: _rotationController,
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(AppImages.iconMusic),
                                  ),
                                ),
                              ),
                            ),
                            Text(
                              "Listen new music",
                              style: TextStyle(
                                  color: context.isDarkMode
                                      ? AppColors.lightBackground
                                      : AppColors.darkGrey),
                            ),
                            const Spacer(),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SongDetailPage(
                                      songId: post.songId,
                                      image: 'https://i.imgur.com/1.jpg',
                                      title: 'Sample Song',
                                      artist: 'Sample Artist',
                                      views: '1.2M Views',
                                      date: '19 Nov 2015',
                                      topSongs: [
                                        {
                                          'image': 'https://i.imgur.com/1.jpg',
                                          'title': 'Sample Song',
                                          'artist': 'Sample Artist',
                                          'duration': '3:45',
                                        },
                                      ],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                padding: EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: context.isDarkMode
                                      ? AppColors.lightBackground
                                      : AppColors.darkGrey,
                                  shape: BoxShape.circle,
                                ),
                                child: SvgPicture.asset(
                                  AppImages.iconTriangle,
                                  colorFilter: ColorFilter.mode(
                                      context.isDarkMode
                                          ? AppColors.darkBackground
                                          : AppColors.lightBackground,
                                      BlendMode.srcIn),
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          post.content,
                          maxLines: isExpanded ? null : 5,
                          overflow: isExpanded ? null : TextOverflow.ellipsis,
                          style: TextStyle(
                              color: context.isDarkMode
                                  ? AppColors.lightBackground
                                  : AppColors.darkGrey,
                              fontSize: 15),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isExpanded) {
                                expandedPostIndexes.remove(index);
                              } else {
                                expandedPostIndexes.add(index);
                              }
                            });
                          },
                          child: Text(
                            isExpanded ? "View Less" : "View All",
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Column(
                                children: [
                                  SvgPicture.asset(
                                    AppImages.iconLike,
                                    colorFilter: ColorFilter.mode(
                                        context.isDarkMode
                                            ? AppColors.lightBackground
                                            : AppColors.darkGrey,
                                        BlendMode.srcIn),
                                  ),
                                  Text("Likes", style: TextStyle(fontSize: 12))
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Column(
                                children: [
                                  SvgPicture.asset(
                                    AppImages.iconComment,
                                    colorFilter: ColorFilter.mode(
                                        context.isDarkMode
                                            ? AppColors.lightBackground
                                            : AppColors.darkGrey,
                                        BlendMode.srcIn),
                                  ),
                                  Text("Comments",
                                      style: TextStyle(fontSize: 12))
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Column(
                                children: [
                                  SvgPicture.asset(
                                    AppImages.iconSend,
                                    colorFilter: ColorFilter.mode(
                                        context.isDarkMode
                                            ? AppColors.lightBackground
                                            : AppColors.darkGrey,
                                        BlendMode.srcIn),
                                  ),
                                  Text("Send", style: TextStyle(fontSize: 12))
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Column(
                                children: [
                                  SvgPicture.asset(
                                    AppImages.iconShare,
                                    colorFilter: ColorFilter.mode(
                                        context.isDarkMode
                                            ? AppColors.lightBackground
                                            : AppColors.darkGrey,
                                        BlendMode.srcIn),
                                  ),
                                  Text("Share", style: TextStyle(fontSize: 12))
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 12),
                          width: double.infinity,
                          height: 1,
                          color: AppColors.grey.withValues(alpha: 0.3),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
