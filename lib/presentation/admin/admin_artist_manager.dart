import 'package:flutter/material.dart';

class AdminArtistManager extends StatelessWidget {
  const AdminArtistManager({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final artists = [
      {'id': 1, 'name': 'Billie Eilish', 'genre': 'Pop'},
      {'id': 2, 'name': 'Doja Cat', 'genre': 'Hip-Hop'},
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Quản lý Tác giả')),
      body: ListView.separated(
        itemCount: artists.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final artist = artists[index];
          return ListTile(
            title: Text(artist['name'] as String),
            subtitle: Text('Thể loại: ${artist['genre']}'),
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
