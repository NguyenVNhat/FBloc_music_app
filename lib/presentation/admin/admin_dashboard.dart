import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/common/helpers/is_dark_mode.dart';
import 'package:flutter_bloc_project/core/config/theme/app_colors.dart';
import 'package:flutter_bloc_project/presentation/home/bloc/songs_cubit.dart';

import 'admin_artist_manager.dart';
import 'admin_blog_manager.dart';
import 'admin_user_manager.dart';
import 'admin_video_manager.dart';
import 'music_manager/pages/admin_music_manager.dart';

class AdminDashboard extends StatefulWidget {
  final VoidCallback onExitAdmin;
  const AdminDashboard({Key? key, required this.onExitAdmin}) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;
  final List<String> _titles = ['Blog', 'Account', 'Music', 'Artist', 'Video'];
  final List<Widget> _pages = [
    AdminBlogManager(),
    AdminUserManager(),
    AdminMusicManager(),
    AdminArtistManager(),
    AdminVideoManager(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SongsCubit(),
      child: Scaffold(
        backgroundColor: context.isDarkMode
            ? AppColors.darkBackground
            : AppColors.lightBackground,
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          title: Row(
            children: [
              const Icon(Icons.admin_panel_settings, color: Colors.blueAccent),
              const SizedBox(width: 8),
              Text('${_titles[_selectedIndex]}',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          actions: [
            const SizedBox(width: 12),
            IconButton(
              icon: const Icon(Icons.logout, color: Colors.redAccent),
              onPressed: widget.onExitAdmin,
              tooltip: 'Thoát quản lý',
            ),
          ],
        ),
        body: Container(
          color: context.isDarkMode ? AppColors.darkBackground : Colors.white,
          child: _pages[_selectedIndex],
        ),
        drawer: Drawer(
          child: Container(
            color: Colors.white,
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(color: Colors.blueAccent),
                  accountName: const Text('Admin',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  accountEmail: const Text('admin@musicapp.com'),
                  currentAccountPicture: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child:
                        Icon(Icons.person, size: 40, color: Colors.blueAccent),
                  ),
                ),
                for (int i = 0; i < _titles.length; i++)
                  ListTile(
                    leading: Icon(
                      [
                        Icons.article,
                        Icons.people,
                        Icons.music_note,
                        Icons.person,
                        Icons.video_library
                      ][i],
                      color:
                          i == _selectedIndex ? Colors.blueAccent : Colors.grey,
                    ),
                    title: Text(_titles[i],
                        style: TextStyle(
                            fontWeight: i == _selectedIndex
                                ? FontWeight.bold
                                : FontWeight.normal)),
                    selected: i == _selectedIndex,
                    selectedTileColor: Colors.blue[50],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    onTap: () {
                      setState(() {
                        _selectedIndex = i;
                      });
                      Navigator.pop(context);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
