import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/core/config/theme/app_images.dart';
import 'package:flutter_bloc_project/domain/entities/video/video.dart';
import 'package:flutter_svg/svg.dart';

class VideoDetailPage extends StatelessWidget {
  final VideoEntity video;

  // Mock data
  final List<Map<String, String>> moreLikeList = const [
    {
      'image': 'https://i.imgur.com/8UG2N6Q.jpg',
      'title': 'Avatar',
    },
    {
      'image': 'https://i.imgur.com/1bX5QH6.jpg',
      'title': 'Interstellar',
    },
    {
      'image': 'https://i.imgur.com/2nCt3Sbl.jpg',
      'title': 'Inception',
    },
  ];

  final List<Map<String, String>> comments = const [
    {
      'user': 'John Doe',
      'avatar': 'https://randomuser.me/api/portraits/men/1.jpg',
      'comment': 'Amazing movie! The visuals are stunning.'
    },
    {
      'user': 'Jane Smith',
      'avatar': 'https://randomuser.me/api/portraits/women/2.jpg',
      'comment': 'Loved the story and the characters.'
    },
    {
      'user': 'Alex Lee',
      'avatar': 'https://randomuser.me/api/portraits/men/3.jpg',
      'comment': 'A must-watch for sci-fi fans.'
    },
  ];

  final String aboutDescription =
      'Jake Sully lives with his newfound family formed on the extrasolar moon Pandora. Once a familiar threat returns to finish what was previously started, Jake must work with Neytiri and the army of the Na\'vi to protect their home.';

  const VideoDetailPage({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF10131A),
      body: DefaultTabController(
        length: 3,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    video.image,
                    width: double.infinity,
                    height: 320,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 40,
                    left: 16,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 16,
                    child: Icon(Icons.more_vert, color: Colors.white),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AppImages.iconTriangle,
                            colorFilter: ColorFilter.mode(
                              Colors.black,
                              BlendMode.srcIn,
                            ),
                            width: 16,
                            height: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.iconStar,
                          colorFilter: ColorFilter.mode(
                            Colors.yellow,
                            BlendMode.srcIn,
                          ),
                        ),
                        Text(' 9.8', style: TextStyle(color: Colors.white)),
                        SizedBox(width: 8),
                        Text('2h 15m', style: TextStyle(color: Colors.white)),
                        SizedBox(width: 8),
                        Text('Action, Science Fiction',
                            style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        IconButton(
                            icon: SvgPicture.asset(
                              AppImages.iconLike,
                              colorFilter: ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                            onPressed: () {}),
                        IconButton(
                            icon: SvgPicture.asset(
                              AppImages.iconBookmark,
                              colorFilter: ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                            onPressed: () {}),
                        IconButton(
                            icon: Icon(Icons.send, color: Colors.white),
                            onPressed: () {}),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      video.content,
                      style: TextStyle(color: Colors.white),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 12),
                    // Trailer section (mock)
                    Text('Trailers',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 100,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 2,
                        separatorBuilder: (_, __) => SizedBox(width: 12),
                        itemBuilder: (context, index) => Container(
                          width: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[800],
                          ),
                          child: Stack(
                            children: [
                              Positioned.fill(
                                child: Image.network(
                                  video.image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Center(
                                child: Icon(Icons.play_circle_fill,
                                    color: Colors.white, size: 40),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Tabs
                    TabBar(
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white54,
                      indicatorColor: Colors.blueAccent,
                      tabs: [
                        Tab(text: 'More Like This'),
                        Tab(text: 'About'),
                        Tab(text: 'Comments'),
                      ],
                    ),
                    SizedBox(
                      height: 340,
                      child: TabBarView(
                        children: [
                          // More Like This
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: moreLikeList.length,
                              separatorBuilder: (_, __) => SizedBox(width: 16),
                              itemBuilder: (context, idx) {
                                final item = moreLikeList[idx];
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        item['image']!,
                                        width: 120,
                                        height: 160,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(item['title']!,
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                );
                              },
                            ),
                          ),
                          // About
                          SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 16),
                                Text('Description:',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Text(aboutDescription,
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(height: 16),
                                Text('Subtitles:',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Text('English, Spanish, Germany, Russian',
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(height: 8),
                                Text('Audio Track:',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Text('English, Spanish',
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(height: 16),
                                Text('Cast and Crew',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    _buildCastAvatar(
                                        'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png',
                                        'Sam Worthington',
                                        'Jake'),
                                    SizedBox(width: 16),
                                    _buildCastAvatar(
                                        'https://upload.wikimedia.org/wikipedia/commons/8/89/Portrait_Placeholder.png',
                                        'Zoe Zaldana',
                                        'Neytiri'),
                                  ],
                                ),
                                SizedBox(height: 16),
                                Text('Gallery',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(height: 8),
                                Row(
                                  children: [
                                    _buildGalleryImage(video.image),
                                    SizedBox(width: 12),
                                    _buildGalleryImage(video.image),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // Comments
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: ListView.separated(
                              itemCount: comments.length,
                              separatorBuilder: (_, __) => SizedBox(height: 16),
                              itemBuilder: (context, idx) {
                                final cmt = comments[idx];
                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(cmt['avatar']!),
                                      radius: 20,
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(cmt['user']!,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                          SizedBox(height: 4),
                                          Text(cmt['comment']!,
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCastAvatar(String imageUrl, String name, String role) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(imageUrl),
          radius: 28,
        ),
        SizedBox(height: 4),
        Text(name, style: TextStyle(color: Colors.white, fontSize: 12)),
        Text(role, style: TextStyle(color: Colors.white54, fontSize: 11)),
      ],
    );
  }

  Widget _buildGalleryImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        imageUrl,
        width: 90,
        height: 60,
        fit: BoxFit.cover,
      ),
    );
  }
}
