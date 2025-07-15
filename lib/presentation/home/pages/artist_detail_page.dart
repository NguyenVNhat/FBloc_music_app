import 'package:flutter/material.dart';

class ArtistDetailPage extends StatelessWidget {
  final String artistName;
  final String artistImage;
  const ArtistDetailPage(
      {Key? key, required this.artistName, required this.artistImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock data
    final albums = [
      {
        'title': 'Lilbubblegum',
        'image': 'https://i.imgur.com/8UG2N6Q.jpg',
      },
      {
        'title': 'Happier Than Ever',
        'image': 'https://i.imgur.com/1bX5QH6.jpg',
      },
      {
        'title': 'Dont Smile At Me',
        'image': 'https://i.imgur.com/2nCt3Sbl.jpg',
      },
    ];
    final songs = [
      {
        'title': 'Dont Smile At Me',
        'artist': artistName,
        'duration': '5:33',
      },
      {
        'title': 'Lilbubblegum',
        'artist': artistName,
        'duration': '5:33',
      },
    ];
    return Scaffold(
      backgroundColor: Color(0xFF232323),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.network(
                    artistImage,
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  artistName,
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(height: 8),
                Text(
                  '2 Album . 67 Track',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                SizedBox(height: 12),
                Text(
                  'Lorem Ipsum Dolor Sit Amet, Consectetur Adipiscing Elit. Turpis Adipiscing Vestibulum Orci Enim, Nascetur Vitae',
                  style: TextStyle(color: Colors.white60, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Albums',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ),
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: albums.length,
                    separatorBuilder: (_, __) => SizedBox(width: 16),
                    itemBuilder: (context, idx) {
                      final album = albums[idx];
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              album['image']!,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(album['title']!,
                              style: TextStyle(color: Colors.white)),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(height: 24),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Songs',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: songs.length,
                  separatorBuilder: (_, __) => SizedBox(height: 12),
                  itemBuilder: (context, idx) {
                    final song = songs[idx];
                    return Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(song['title']!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                              Text(song['artist']!,
                                  style: TextStyle(
                                      color: Colors.white54, fontSize: 13)),
                            ],
                          ),
                        ),
                        Text(song['duration']!,
                            style: TextStyle(color: Colors.white)),
                        SizedBox(width: 12),
                        Icon(Icons.favorite_border, color: Colors.white),
                      ],
                    );
                  },
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
