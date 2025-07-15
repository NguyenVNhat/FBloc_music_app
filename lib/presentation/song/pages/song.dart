import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_project/common/helpers/is_dark_mode.dart';
import 'package:flutter_bloc_project/common/widgets/appbars/app_bar_detail.dart';
import 'package:flutter_bloc_project/core/config/theme/app_colors.dart';
import 'package:flutter_bloc_project/core/config/theme/app_images.dart';
import 'package:flutter_bloc_project/presentation/song/bloc/song_cubit.dart';
import 'package:flutter_bloc_project/presentation/song/bloc/song_state.dart';
import 'package:flutter_bloc_project/presentation/song/pages/lyrics.dart';
import 'package:flutter_svg/svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SongPage extends StatefulWidget {
  final String songId;

  const SongPage({super.key, required this.songId});

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  YoutubePlayerController? controller;
  bool _isControllerReady = false;
  String? _currentVideoId;
  bool _isPlaying = false;
  Timer? _debounceTimer;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void dispose() {
    _debounceTimer?.cancel();
    controller?.dispose();
    super.dispose();
  }

  void _initializeController(String videoId) {
    if (_currentVideoId == videoId && controller != null) {
      return; // Already initialized with this video
    }

    // Dispose old controller if exists
    controller?.dispose();
    _debounceTimer?.cancel();

    _currentVideoId = videoId;
    _isControllerReady = false;
    _isPlaying = false;
    _currentPosition = Duration.zero;
    _totalDuration = Duration.zero;

    try {
      controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          enableCaption: false,
          hideControls: true,
        ),
      );

      controller!.addListener(_onPlayerStateChanged);

      print('YouTube controller initialized for video: $videoId');
    } catch (e) {
      print('Error initializing YouTube controller: $e');
      _isControllerReady = false;
    }
  }

  void _onPlayerStateChanged() {
    if (!mounted) return;

    // Debounce the state changes to reduce rebuilds
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 100), () {
      if (!mounted) return;

      final isReady = controller?.value.isReady ?? false;
      final isPlaying = controller?.value.isPlaying ?? false;
      final position = controller?.value.position ?? Duration.zero;
      final duration = controller?.metadata.duration ?? Duration.zero;

      bool shouldRebuild = false;

      if (isReady != _isControllerReady) {
        _isControllerReady = isReady;
        shouldRebuild = true;
        print('Controller ready state changed: $_isControllerReady');
      }

      if (isPlaying != _isPlaying) {
        _isPlaying = isPlaying;
        shouldRebuild = true;
      }

      // Only update position if it changed significantly (more than 1 second)
      if ((position - _currentPosition).abs().inSeconds > 0) {
        _currentPosition = position;
        shouldRebuild = true;
      }

      if (duration != _totalDuration) {
        _totalDuration = duration;
        shouldRebuild = true;
      }

      if (shouldRebuild) {
        setState(() {});
      }
    });
  }

  void _togglePlayPause() {
    if (!_isControllerReady || controller == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đang tải dữ liệu, vui lòng đợi...'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    if (_isPlaying) {
      controller!.pause();
    } else {
      controller!.play();
    }
  }

  void _seekTo(Duration position) {
    if (_isControllerReady && controller != null) {
      controller!.seekTo(position);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarDetail(
        title: const Text(
          'Now playing',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocProvider(
        create: (_) => SongCubit()..getSong(widget.songId),
        child: BlocConsumer<SongCubit, SongState>(
          listener: (context, state) {
            if (state is SongLoaded) {
              print('Song loaded: ${state.song.title}');
              print('Original URI: ${state.song.uri}');

              final videoId = _extractVideoId(state.song.uri);
              print('Extracted video ID: $videoId');

              if (videoId.isNotEmpty) {
                _initializeController(videoId);
              } else {
                print('Could not extract video ID from URI: ${state.song.uri}');
              }
            }
          },
          builder: (context, state) {
            if (state is SongLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is SongLoaded) {
              final song = state.song;
              final videoId = _extractVideoId(song.uri);

              if (videoId.isEmpty) {
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
                        "Không thể phát bài hát này",
                        style: TextStyle(
                          color: Colors.red[600],
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "URL không hợp lệ hoặc không phải YouTube",
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                );
              }

              if (controller == null) {
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 16),
                      Text('Đang khởi tạo player...'),
                    ],
                  ),
                );
              }

              return CustomScrollView(
                slivers: [
                  // YouTube Player
                  SliverToBoxAdapter(
                    child: Container(
                      height: 300,
                      margin: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: NetworkImage(song.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Opacity(
                        opacity: 0,
                        child: YoutubePlayer(
                          controller: controller!,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: const Color(0xFF1ED760),
                          progressColors: const ProgressBarColors(
                            playedColor: Color(0xFF1ED760),
                            handleColor: Color(0xFF1ED760),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Song Info + Heart
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  song.title,
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: context.isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  song.artist,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: context.isDarkMode
                                        ? Colors.white70
                                        : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            icon: SvgPicture.asset(AppImages.iconHeart,
                                colorFilter: ColorFilter.mode(
                                  context.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  BlendMode.srcIn,
                                ),
                                width: 28,
                                height: 28),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Progress Bar
                  if (_isControllerReady)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Column(
                          children: [
                            Slider(
                              value: _currentPosition.inSeconds
                                  .toDouble()
                                  .clamp(
                                      0, _totalDuration.inSeconds.toDouble()),
                              min: 0,
                              max: _totalDuration.inSeconds.toDouble(),
                              onChanged: (value) {
                                _seekTo(Duration(seconds: value.toInt()));
                              },
                              activeColor: context.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              inactiveColor: context.isDarkMode
                                  ? Colors.white24
                                  : Colors.black26,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _formatDuration(_currentPosition),
                                    style: TextStyle(
                                      color: context.isDarkMode
                                          ? Colors.white70
                                          : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    _formatDuration(_totalDuration),
                                    style: TextStyle(
                                      color: context.isDarkMode
                                          ? Colors.white70
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Column(
                          children: [
                            Slider(
                              value: 0,
                              min: 0,
                              max: 0,
                              onChanged: (value) {},
                              activeColor: context.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              inactiveColor: context.isDarkMode
                                  ? Colors.white24
                                  : Colors.black26,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _formatDuration(_currentPosition),
                                    style: TextStyle(
                                      color: context.isDarkMode
                                          ? Colors.white70
                                          : Colors.black,
                                    ),
                                  ),
                                  Text(
                                    _formatDuration(_totalDuration),
                                    style: TextStyle(
                                      color: context.isDarkMode
                                          ? Colors.white70
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  // Playback Controls
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: SvgPicture.asset(AppImages.iconReplay,
                                colorFilter: ColorFilter.mode(
                                  context.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  BlendMode.srcIn,
                                ),
                                width: 28,
                                height: 28),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: SvgPicture.asset(AppImages.iconPreSong,
                                colorFilter: ColorFilter.mode(
                                  context.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  BlendMode.srcIn,
                                ),
                                width: 28,
                                height: 28),
                            onPressed: () {},
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.primary, // Spotify green
                            ),
                            child: IconButton(
                              icon: Icon(
                                _isPlaying
                                    ? Icons.pause_rounded
                                    : Icons.play_arrow_rounded,
                                color: Colors.black,
                                size: 36,
                              ),
                              onPressed: _togglePlayPause,
                            ),
                          ),
                          IconButton(
                            icon: SvgPicture.asset(AppImages.iconNext,
                                colorFilter: ColorFilter.mode(
                                  context.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  BlendMode.srcIn,
                                ),
                                width: 28,
                                height: 28),
                            onPressed: () {},
                          ),
                          IconButton(
                            icon: SvgPicture.asset(AppImages.iconShuffle,
                                colorFilter: ColorFilter.mode(
                                  context.isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  BlendMode.srcIn,
                                ),
                                width: 28,
                                height: 28),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Lyrics Button
                  SliverToBoxAdapter(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => LyricsPage(
                            title: song.title,
                            artist: song.artist,
                            imageUrl: song.image,
                            lyrics: [
                              'Lyrics line 1',
                              'Lyrics line 2',
                              'Lyrics line 3',
                            ],
                            currentLine: 0,
                            controller: controller,
                            isPlaying: _isPlaying,
                            currentPosition: _currentPosition,
                            totalDuration: _totalDuration,
                            onPlayPause: _togglePlayPause,
                            onSeek: _seekTo,
                            onPrevious: () {
                              // TODO: Implement previous song
                            },
                            onNext: () {
                              // TODO: Implement next song
                            },
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Column(
                          children: [
                            Icon(Icons.keyboard_arrow_up,
                                color: context.isDarkMode
                                    ? Colors.white70
                                    : Colors.black),
                            Text(
                              'Lyrics',
                              style: TextStyle(
                                color: context.isDarkMode
                                    ? Colors.white70
                                    : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return const Center(child: Text("Không tìm thấy bài hát."));
          },
        ),
      ),
    );
  }
}

String _extractVideoId(String url) {
  if (url.isEmpty) return '';

  // Handle different YouTube URL formats
  final patterns = [
    RegExp(
        r'(?:youtube\.com\/watch\?v=|youtu\.be\/|youtube\.com\/embed\/)([a-zA-Z0-9_-]{11})'),
    RegExp(r'youtube\.com\/watch\?.*v=([a-zA-Z0-9_-]{11})'),
  ];

  for (final pattern in patterns) {
    final match = pattern.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!;
    }
  }

  // If no pattern matches, assume it's already a video ID
  if (url.length == 11 && RegExp(r'^[a-zA-Z0-9_-]{11}$').hasMatch(url)) {
    return url;
  }

  return '';
}

String _formatDuration(Duration d) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = twoDigits(d.inMinutes.remainder(60));
  final seconds = twoDigits(d.inSeconds.remainder(60));
  return '$minutes:$seconds';
}
