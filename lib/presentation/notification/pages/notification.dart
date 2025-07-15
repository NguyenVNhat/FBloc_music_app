import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'icon': Icons.music_note,
        'title': 'New Album Released',
        'subtitle': 'Billie Eilish - Happier Than Ever',
        'time': '2m ago',
      },
      {
        'icon': Icons.favorite,
        'title': 'Playlist Liked',
        'subtitle': 'You liked "Top Hits 2024"',
        'time': '10m ago',
      },
      {
        'icon': Icons.person_add,
        'title': 'New Follower',
        'subtitle': 'Alex started following you',
        'time': '1h ago',
      },
      {
        'icon': Icons.notifications,
        'title': 'App Update',
        'subtitle': 'Version 2.0 is now available!',
        'time': '3h ago',
      },
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF232323),
        elevation: 0,
        title:
            const Text('Notifications', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFF181818),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const Divider(
            color: Colors.white12, height: 1, indent: 24, endIndent: 24),
        itemBuilder: (context, index) {
          final n = notifications[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: const Color(0xFF43E97B).withOpacity(0.15),
              child:
                  Icon(n['icon'] as IconData, color: const Color(0xFF43E97B)),
            ),
            title: Text(
              n['title'] as String,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              n['subtitle'] as String,
              style: const TextStyle(color: Colors.white70),
            ),
            trailing: Text(
              n['time'] as String,
              style: const TextStyle(color: Colors.white38, fontSize: 12),
            ),
            onTap: () {},
          );
        },
      ),
    );
  }
}
