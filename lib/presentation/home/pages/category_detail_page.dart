import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/domain/entities/genres/genres.dart';

class CategoryDetailPage extends StatelessWidget {
  final GenresEntity item;
  const CategoryDetailPage({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181829),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: Text(
          item.name,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        children: [
          // Card thông tin category
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.06),
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    item.image,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        item.description,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: item.tag
                            .map((tag) => Chip(
                                  label: Text(tag,
                                      style: const TextStyle(fontSize: 12)),
                                  backgroundColor: Colors.white12,
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          const Text(
            'Featured Artists',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
          ),
          const SizedBox(height: 14),
          // SizedBox(
          //   height: 80,
          //   child: ListView.separated(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: artists.length,
          //     separatorBuilder: (_, __) => const SizedBox(width: 18),
          //     itemBuilder: (context, index) {
          //       final artist = artists[index];
          //       return Column(
          //         children: [
          //           CircleAvatar(
          //             radius: 26,
          //             backgroundImage: NetworkImage(artist['image'] as String),
          //           ),
          //           const SizedBox(height: 6),
          //           Text(
          //             artist['name'] as String,
          //             style: const TextStyle(
          //               color: Colors.white,
          //               fontSize: 13,
          //               fontWeight: FontWeight.w500,
          //             ),
          //           ),
          //         ],
          //       );
          //     },
          //   ),
          // ),
          // const SizedBox(height: 14),

          // // Top Albums
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: const [
          //     Text(
          //       'Top Albums',
          //       style: TextStyle(
          //           color: Colors.white,
          //           fontWeight: FontWeight.bold,
          //           fontSize: 17),
          //     ),
          //     Text(
          //       'See all',
          //       style: TextStyle(
          //           color: Colors.blueAccent,
          //           fontWeight: FontWeight.w500,
          //           fontSize: 14),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 14),
          // SizedBox(
          //   height: 110,
          //   child: ListView.separated(
          //     scrollDirection: Axis.horizontal,
          //     itemCount: albums.length,
          //     separatorBuilder: (_, __) => const SizedBox(width: 16),
          //     itemBuilder: (context, index) {
          //       final album = albums[index];
          //       return Column(
          //         children: [
          //           ClipRRect(
          //             borderRadius: BorderRadius.circular(12),
          //             child: Image.network(
          //               album['image'] as String,
          //               width: 80,
          //               height: 80,
          //               fit: BoxFit.cover,
          //             ),
          //           ),
          //           const SizedBox(height: 6),
          //           Text(
          //             album['title'] as String,
          //             maxLines: 1,
          //             overflow: TextOverflow.ellipsis,
          //             style: const TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 13,
          //                 fontWeight: FontWeight.w500),
          //           ),
          //         ],
          //       );
          //     },
          //   ),
          // ),
          // const SizedBox(height: 14),

          // // Top Songs
          // const Text(
          //   'Top Songs',
          //   style: TextStyle(
          //       color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17),
          // ),
          // const SizedBox(height: 14),
          // ...songs.map((song) => Container(
          //       margin: const EdgeInsets.only(bottom: 12),
          //       decoration: BoxDecoration(
          //         color: Colors.white.withOpacity(0.04),
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //       child: ListTile(
          //         leading: ClipRRect(
          //           borderRadius: BorderRadius.circular(8),
          //           child: Image.network(
          //             song['image'] as String,
          //             width: 48,
          //             height: 48,
          //             fit: BoxFit.cover,
          //           ),
          //         ),
          //         title: Text(
          //           song['title'] as String,
          //           style: const TextStyle(
          //               color: Colors.white, fontWeight: FontWeight.w600),
          //         ),
          //         subtitle: Text(
          //           song['artist'] as String,
          //           style: const TextStyle(color: Colors.white70, fontSize: 13),
          //         ),
          //         trailing: Icon(Icons.play_circle_fill,
          //             color: Colors.blueAccent, size: 32),
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => SongDetailPage(
          //                 songId: 'S1',
          //                 image: song['image'] as String,
          //                 title: song['title'] as String,
          //                 artist: song['artist'] as String,
          //                 views: '1.2M Views',
          //                 date: '19 Nov 2015',
          //                 topSongs: [
          //                   song,
          //                   // ... add more mock songs if needed
          //                 ],
          //               ),
          //             ),
          //           );
          //         },
          //       ),
          //     )),

          // Featured Artists

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
