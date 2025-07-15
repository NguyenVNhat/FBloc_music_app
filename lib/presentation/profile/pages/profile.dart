import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/presentation/upload/pages/upload_music.dart';

class ProfilePage extends StatelessWidget {
  final VoidCallback? onSwitchToAdmin;
  const ProfilePage({Key? key, this.onSwitchToAdmin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Container(
                  height: 240,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF43E97B), Color(0xFF38F9D7)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
                Positioned(
                  top: 48,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 54,
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(
                            'https://randomuser.me/api/portraits/men/32.jpg'),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Your Name',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'your.email@example.com',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Stats Row
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _statColumn('Followers', '778'),
                  _statColumn('Following', '243'),
                  _statColumn('Playlists', '6'),
                ],
              ),
            ),
          ),
          // Action Buttons
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
                children: [
                  _actionButton(
                    context,
                    icon: Icons.settings,
                    label: 'Settings',
                    onTap: () {
                      // TODO: Navigate to settings page
                    },
                  ),
                  _actionButton(
                    context,
                    icon: Icons.lock_outline,
                    label: 'Change Password',
                    onTap: () {
                      // TODO: Navigate to change password page
                    },
                  ),
                  _actionButton(
                    context,
                    icon: Icons.cloud_upload,
                    label: 'Upload Music',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const UploadMusicPage()),
                      );
                    },
                  ),
                  _actionButton(
                    context,
                    icon: Icons.admin_panel_settings,
                    label: 'Chuyển sang quản lý',
                    onTap: () {
                      if (onSwitchToAdmin != null) onSwitchToAdmin!();
                    },
                  ),
                  _actionButton(
                    context,
                    icon: Icons.logout,
                    label: 'Log Out',
                    onTap: () {
                      // TODO: Handle log out
                    },
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  Widget _statColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
      ],
    );
  }

  Widget _actionButton(BuildContext context,
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return Card(
      color: const Color(0xFF232323),
      elevation: 1,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        leading: Icon(icon, color: Colors.greenAccent),
        title: Text(label,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500)),
        trailing: const Icon(Icons.arrow_forward_ios,
            color: Colors.white38, size: 18),
        onTap: onTap,
      ),
    );
  }
}
