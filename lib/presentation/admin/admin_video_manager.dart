import 'package:flutter/material.dart';

class AdminVideoManager extends StatelessWidget {
  const AdminVideoManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final videos = [
      {
        'id': 1,
        'title': 'Live at Blue Note',
        'artist': 'jazzcat',
        'status': 'Published'
      },
      {
        'id': 2,
        'title': 'Indie Summer',
        'artist': 'music_lover',
        'status': 'Pending'
      },
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý Video')),
      body: ListView.separated(
        itemCount: videos.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final video = videos[index];
          return ListTile(
            title: Text(video['title'] as String),
            subtitle:
                Text('Artist: ${video['artist']} - Status: ${video['status']}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
                IconButton(icon: const Icon(Icons.delete), onPressed: () {}),
              ],
            ),
            onTap: () {},
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
