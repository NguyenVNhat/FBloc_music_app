import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/common/helpers/is_dark_mode.dart';
import 'package:flutter_bloc_project/core/config/theme/app_colors.dart';
import 'package:flutter_bloc_project/core/config/theme/app_images.dart';
import 'package:flutter_bloc_project/presentation/blog/pages/blog.dart';
import 'package:flutter_bloc_project/presentation/home/widgets/artists_card.dart';
import 'package:flutter_bloc_project/presentation/home/widgets/banner_carousel.dart';
import 'package:flutter_bloc_project/presentation/home/widgets/categories_list.dart';
import 'package:flutter_bloc_project/presentation/home/widgets/home_header.dart';
import 'package:flutter_bloc_project/presentation/home/widgets/search_form_field.dart';
import 'package:flutter_bloc_project/presentation/home/widgets/songs_card.dart';
import 'package:flutter_bloc_project/presentation/home/widgets/songs_list.dart';
import 'package:flutter_bloc_project/presentation/home/widgets/videos_card.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late final TabController tabBarController;

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    tabBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          context.isDarkMode ? AppColors.darkBackground : Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 16,
          children: [
            HomeHeader(),
            BannerCarousel(),
            SearchFormField(),
            CategoriesList(),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const BlogPage()),
                );
              },
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 12, left: 12, right: 12),
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, Colors.black],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  spacing: 8,
                  children: [
                    SvgPicture.asset(AppImages.iconBlog,
                        colorFilter: ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                        width: 36,
                        height: 36),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Read posts & status about music from the community',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.arrow_forward_ios,
                        color: Colors.white, size: 20),
                  ],
                ),
              ),
            ),
            _tabs(context),
            SizedBox(
              height: 240,
              child: TabBarView(
                controller: tabBarController,
                children: [
                  SongsCard(),
                  VideosCard(),
                  ArtistsCard(),
                  Container()
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "Play list",
                style: TextStyle(
                    color: context.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SongsList(),
          ],
        ),
      ),
    );
  }

  Widget _tabs(BuildContext context) {
    return TabBar(
      controller: tabBarController,
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      isScrollable: true,
      indicatorColor: AppColors.primary,
      dividerColor: Colors.transparent,
      tabAlignment: TabAlignment.center,
      labelPadding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      tabs: [Text("News"), Text("Videos"), Text("Artists"), Text("Podcasts")],
    );
  }
}
