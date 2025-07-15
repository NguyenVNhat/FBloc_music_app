import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/common/helpers/is_dark_mode.dart';
import 'package:flutter_bloc_project/core/config/theme/app_colors.dart';
import 'package:flutter_bloc_project/core/config/theme/app_images.dart';
import 'package:flutter_bloc_project/core/config/theme/app_theme.dart';
import 'package:flutter_bloc_project/presentation/choose_mode/bloc/theme_cubit.dart';
import 'package:flutter_bloc_project/service_locator.dart';
import 'package:flutter_svg/svg.dart';

import 'presentation/explore/pages/explore.dart';
import 'presentation/favorite/pages/favorite.dart';
import 'presentation/home/pages/home.dart';
import 'presentation/profile/pages/profile.dart';
import 'presentation/splash/pages/splash.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await Firebase.initializeApp();
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  bool isAdminMode = false;

  void switchRole(bool admin) {
    setState(() {
      isAdminMode = admin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            home: SplashPage(),
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

class MainNavigation extends StatefulWidget {
  final VoidCallback onSwitchToAdmin;
  const MainNavigation({Key? key, required this.onSwitchToAdmin})
      : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(),
      ExplorePage(),
      FavoritePage(),
      ProfilePage(onSwitchToAdmin: widget.onSwitchToAdmin),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: AppColors.primary,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: AppColors.primary,
        unselectedItemColor:
            context.isDarkMode ? AppColors.lightBackground : AppColors.darkGrey,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AppImages.iconHome,
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 0
                        ? AppColors.primary
                        : context.isDarkMode
                            ? AppColors.lightBackground
                            : AppColors.darkGrey,
                    BlendMode.srcIn,
                  )),
              label: 'Home'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AppImages.iconExplore,
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 1
                        ? AppColors.primary
                        : context.isDarkMode
                            ? AppColors.lightBackground
                            : AppColors.darkGrey,
                    BlendMode.srcIn,
                  ),
                  width: 28,
                  height: 28),
              label: 'Explore'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AppImages.iconHeart,
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 2
                        ? AppColors.primary
                        : context.isDarkMode
                            ? AppColors.lightBackground
                            : AppColors.darkGrey,
                    BlendMode.srcIn,
                  ),
                  width: 28,
                  height: 28),
              label: 'Favorite'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(AppImages.iconUser,
                  colorFilter: ColorFilter.mode(
                    _selectedIndex == 3
                        ? AppColors.primary
                        : context.isDarkMode
                            ? AppColors.lightBackground
                            : AppColors.darkGrey,
                    BlendMode.srcIn,
                  ),
                  width: 28,
                  height: 28),
              label: 'Profile'),
        ],
      ),
    );
  }
}
