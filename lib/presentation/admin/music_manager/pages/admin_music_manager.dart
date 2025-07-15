import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/common/helpers/is_dark_mode.dart';
import 'package:flutter_bloc_project/core/config/theme/app_colors.dart';
import 'package:flutter_bloc_project/domain/entities/song/song.dart';
import 'package:flutter_bloc_project/presentation/home/bloc/songs_cubit.dart';
import 'package:flutter_bloc_project/presentation/home/bloc/songs_state.dart';

// Constants
class MusicConstants {
  static const List<String> genres = [
    'Pop',
    'R&B',
    'Rock',
    'Hip Hop',
    'Jazz',
    'Classical',
  ];

  static const List<String> statuses = [
    'Published',
    'Pending',
    'Draft',
  ];

  static const double cardBorderRadius = 12.0;
  static const double chipBorderRadius = 8.0;
  static const double iconSize = 24.0;
  static const double avatarSize = 50.0;
}

// Main Widget
class AdminMusicManager extends StatefulWidget {
  const AdminMusicManager({Key? key}) : super(key: key);

  @override
  State<AdminMusicManager> createState() => _AdminMusicManagerState();
}

class _AdminMusicManagerState extends State<AdminMusicManager> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<SongsCubit>().getSongs();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SongsCubit, SongsState>(
      listener: (context, state) {
        if (state is SongsError) {
          _showErrorMessage(state.message);
        }
      },
      child: Stack(
        children: [
          Container(
            color: context.isDarkMode ? Colors.black : Colors.grey[50],
            child: Column(
              children: [
                Expanded(
                  child: BlocBuilder<SongsCubit, SongsState>(
                    builder: (context, state) {
                      if (state is SongsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (state is SongsLoaded) {
                        if (state.songs.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.music_note,
                                  size: 64,
                                  color: Colors.grey[400],
                                ),
                                const SizedBox(height: 16),
                                Text(
                                  "Chưa có bài hát nào...",
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return MusicListView(
                          musics: state.songs,
                          onEdit: _handleEditMusic,
                          onDelete: _handleDeleteMusic,
                        );
                      }

                      if (state is SongsError) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 64,
                                color: Colors.red[300],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                "Có lỗi xảy ra",
                                style: TextStyle(
                                  color: Colors.red[600],
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () {
                                  context.read<SongsCubit>().getSongs();
                                },
                                child: const Text("Thử lại"),
                              ),
                            ],
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton.extended(
              onPressed: _handleAddMusic,
              backgroundColor: AppColors.primary,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                "Thêm bài hát",
                style: TextStyle(color: Colors.white),
              ),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleAddMusic() {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<SongsCubit>(),
        child: MusicDialog(
          onSave: (music) async {
            await context.read<SongsCubit>().addSong(music);
            if (mounted) {
              _showSuccessMessage('Đã thêm bài hát thành công!');
            }
          },
        ),
      ),
    );
  }

  void _handleEditMusic(SongEntity music) {
    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<SongsCubit>(),
        child: MusicDialog(
          music: music,
          onSave: (updatedMusic) async {
            await context.read<SongsCubit>().updateSong(updatedMusic);
            if (mounted) {
              _showSuccessMessage('Đã cập nhật bài hát thành công!');
            }
          },
        ),
      ),
    );
  }

  void _handleDeleteMusic(SongEntity music) {
    final songsCubit = context.read<SongsCubit>();
    showDialog(
      context: context,
      builder: (dialogContext) => DeleteConfirmationDialog(
        musicTitle: music.title,
        onConfirm: () async {
          await songsCubit.deleteSong(music.id);
          if (mounted) {
            _showSuccessMessage('Đã xóa bài hát "${music.title}" thành công!');
          }
        },
      ),
    );
  }

  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

// Music List View
class MusicListView extends StatelessWidget {
  final List<SongEntity> musics;
  final Function(SongEntity) onEdit;
  final Function(SongEntity) onDelete;

  const MusicListView({
    Key? key,
    required this.musics,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: musics.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final music = musics[index];
        return MusicCard(
          music: music,
          onEdit: () => onEdit(music),
          onDelete: () => onDelete(music),
        );
      },
    );
  }
}

// Music Card
class MusicCard extends StatelessWidget {
  final SongEntity music;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const MusicCard({
    Key? key,
    required this.music,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    return Material(
      color: isDark ? const Color(0xFF21222C) : Colors.white,
      borderRadius: BorderRadius.circular(MusicConstants.cardBorderRadius),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(MusicConstants.cardBorderRadius),
        onTap: onEdit,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildMusicAvatar(context),
              const SizedBox(width: 12),
              Expanded(child: _buildMusicContent(context)),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMusicAvatar(BuildContext context) {
    final isDark = context.isDarkMode;
    final color = isDark
        ? AppColors.primary.withOpacity(0.22)
        : AppColors.primary.withOpacity(0.09);

    return Container(
      width: MusicConstants.avatarSize,
      height: MusicConstants.avatarSize,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: music.image.isNotEmpty
            ? Image.network(
                music.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.music_note,
                    color: AppColors.primary,
                    size: 24,
                  );
                },
              )
            : Icon(
                Icons.music_note,
                color: AppColors.primary,
                size: 24,
              ),
      ),
    );
  }

  Widget _buildMusicContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                music.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  height: 1.2,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            DurationChip(duration: _formatDuration(music.duration)),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          music.artist,
          style: TextStyle(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onEdit,
          icon: const Icon(Icons.edit_outlined, color: Colors.blue),
          tooltip: 'Chỉnh sửa',
        ),
        IconButton(
          onPressed: onDelete,
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          tooltip: 'Xóa',
        ),
      ],
    );
  }

  String _formatDuration(num duration) {
    final minutes = (duration / 60).floor();
    final seconds = (duration % 60).floor();
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

// Status Chip
class StatusChip extends StatelessWidget {
  final String status;

  const StatusChip({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color bg, fg;
    switch (status) {
      case 'Published':
        bg = Colors.green[100]!;
        fg = Colors.green[800]!;
        break;
      case 'Pending':
        bg = Colors.orange[100]!;
        fg = Colors.orange[800]!;
        break;
      default:
        bg = Colors.grey[200]!;
        fg = Colors.grey[700]!;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }
}

// Genre Chip
class GenreChip extends StatelessWidget {
  final String genre;

  const GenreChip({Key? key, required this.genre}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        genre,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

// Duration Chip
class DurationChip extends StatelessWidget {
  final String duration;

  const DurationChip({Key? key, required this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        duration,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.blue,
        ),
      ),
    );
  }
}

// Delete Confirmation Dialog
class DeleteConfirmationDialog extends StatelessWidget {
  final String musicTitle;
  final VoidCallback onConfirm;

  const DeleteConfirmationDialog({
    Key? key,
    required this.musicTitle,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: Colors.red[400], size: 24),
          const SizedBox(width: 8),
          const Text('Xác nhận xóa'),
        ],
      ),
      content: Text('Bạn có chắc muốn xóa bài hát "$musicTitle"?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          child: const Text('Xóa'),
        ),
      ],
    );
  }
}

// Music Dialog
class MusicDialog extends StatefulWidget {
  final SongEntity? music;
  final Function(SongEntity) onSave;

  const MusicDialog({
    Key? key,
    this.music,
    required this.onSave,
  }) : super(key: key);

  @override
  State<MusicDialog> createState() => _MusicDialogState();
}

class _MusicDialogState extends State<MusicDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _artistController;
  late TextEditingController _durationController;
  late TextEditingController _imageController;
  late TextEditingController _uriController;
  late String _selectedGenre;
  late String _selectedStatus;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.music?.title ?? '');
    _artistController = TextEditingController(text: widget.music?.artist ?? '');
    _durationController = TextEditingController(
      text: widget.music?.duration.toString() ?? '300',
    );
    _imageController = TextEditingController(text: widget.music?.image ?? '');
    _uriController = TextEditingController(text: widget.music?.uri ?? '');
    _selectedGenre = MusicConstants.genres.first;
    _selectedStatus = MusicConstants.statuses.first;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _artistController.dispose();
    _durationController.dispose();
    _imageController.dispose();
    _uriController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.music_note_rounded,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.music == null
                          ? 'Thêm bài hát mới'
                          : 'Chỉnh sửa bài hát',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildTextField(
                  controller: _titleController,
                  label: 'Tên bài hát',
                  icon: Icons.title,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập tên bài hát';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _artistController,
                  label: 'Nghệ sĩ',
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập tên nghệ sĩ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _durationController,
                  label: 'Thời lượng (giây)',
                  icon: Icons.timer,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập thời lượng';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Vui lòng nhập số hợp lệ';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _imageController,
                  label: 'URL hình ảnh',
                  icon: Icons.image,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập URL hình ảnh';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  controller: _uriController,
                  label: 'URL bài hát',
                  icon: Icons.link,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập URL bài hát';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Hủy'),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: _handleSave,
                      child: Text(widget.music == null ? 'Thêm' : 'Lưu'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 16,
        ),
      ),
      validator: validator,
    );
  }

  void _handleSave() {
    if (_formKey.currentState!.validate()) {
      final music = SongEntity(
        id: widget.music?.id ??
            DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text.trim(),
        artist: _artistController.text.trim(),
        duration: int.parse(_durationController.text.trim()),
        releaseDate: Timestamp.now(),
        image: _imageController.text.trim(),
        uri: _uriController.text.trim(),
      );

      Navigator.pop(context);
      widget.onSave(music);
    }
  }
}
