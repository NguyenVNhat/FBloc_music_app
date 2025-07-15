import 'package:flutter/material.dart';
import 'package:flutter_bloc_project/core/config/theme/app_colors.dart';
import 'package:flutter_bloc_project/core/config/theme/app_images.dart';
import 'package:flutter_svg/svg.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LyricsPage extends StatefulWidget {
  final String title;
  final String artist;
  final String imageUrl;
  final List<String> lyrics;
  final int currentLine;
  final YoutubePlayerController? controller;
  final bool isPlaying;
  final Duration currentPosition;
  final Duration totalDuration;
  final VoidCallback? onPlayPause;
  final Function(Duration)? onSeek;
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;

  const LyricsPage({
    Key? key,
    required this.title,
    required this.artist,
    required this.imageUrl,
    required this.lyrics,
    this.currentLine = 0,
    this.controller,
    this.isPlaying = false,
    this.currentPosition = Duration.zero,
    this.totalDuration = Duration.zero,
    this.onPlayPause,
    this.onSeek,
    this.onPrevious,
    this.onNext,
  }) : super(key: key);

  @override
  State<LyricsPage> createState() => _LyricsPageState();
}

class _LyricsPageState extends State<LyricsPage> with TickerProviderStateMixin {
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;
  bool _isPlaying = false;

  late AnimationController _rotationController;
  late AnimationController _replayController;

  @override
  void initState() {
    super.initState();
    _currentPosition = widget.currentPosition;
    _totalDuration = widget.totalDuration;
    _isPlaying = widget.isPlaying;

    // Initialize animation controllers
    _rotationController = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );

    _replayController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    // Start rotation animation if playing
    _rotationController.repeat();

    // Listen to controller changes if available
    widget.controller?.addListener(_onPlayerStateChanged);
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onPlayerStateChanged);
    _rotationController.dispose();
    _replayController.dispose();
    super.dispose();
  }

  void _onPlayerStateChanged() {
    if (mounted && widget.controller != null) {
      setState(() {
        _currentPosition = widget.controller!.value.position;
        _totalDuration = widget.controller!.metadata.duration;
        _isPlaying = widget.controller!.value.isPlaying;
      });
    }
  }

  void _handlePlayPause() {
    if (widget.onPlayPause != null) {
      widget.onPlayPause!();
    } else if (widget.controller != null) {
      if (_isPlaying) {
        widget.controller!.pause();
      } else {
        widget.controller!.play();
      }
    }
  }

  void _handleSeek(Duration position) {
    if (widget.onSeek != null) {
      widget.onSeek!(position);
    } else if (widget.controller != null && widget.controller!.value.isReady) {
      widget.controller!.seekTo(position);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background image with green overlay
          Positioned.fill(
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.green.withOpacity(0.7),
                BlendMode.srcATop,
              ),
              child: Image.network(
                widget.imageUrl,
                fit: BoxFit.cover,
                color: Colors.black.withOpacity(0.5),
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                Center(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Center(
                  child: Text(
                    widget.artist,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    itemCount: widget.lyrics.length,
                    itemBuilder: (context, index) {
                      final isCurrent = index == widget.currentLine;
                      final isVerse =
                          widget.lyrics[index].trim().startsWith('(') &&
                              widget.lyrics[index].trim().endsWith(')');
                      if (isVerse) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: Text(
                            widget.lyrics[index],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          widget.lyrics[index],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: isCurrent
                                ? Colors.white
                                : Colors.white.withOpacity(0.6),
                            fontSize: isCurrent ? 22 : 20,
                            fontWeight:
                                isCurrent ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Player bar with real functionality
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: RotationTransition(
                              turns: _rotationController,
                              child: Image.network(
                                widget.imageUrl,
                                width: 48,
                                height: 48,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  widget.artist,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SvgPicture.asset(AppImages.iconHeart,
                              colorFilter: ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                              width: 28,
                              height: 28),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Real Progress bar
                      Row(
                        children: [
                          Text(
                            _formatDuration(_currentPosition),
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 12),
                          ),
                          Expanded(
                            child: Slider(
                              value: _currentPosition.inSeconds
                                  .toDouble()
                                  .clamp(
                                      0, _totalDuration.inSeconds.toDouble()),
                              min: 0,
                              max: _totalDuration.inSeconds.toDouble(),
                              onChanged: (value) {
                                _handleSeek(Duration(seconds: value.toInt()));
                              },
                              activeColor: AppColors.primary,
                              inactiveColor: Colors.white24,
                            ),
                          ),
                          Text(
                            _formatDuration(_totalDuration),
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 12),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _replayController.forward().then((_) {
                                _replayController.reset();
                              });
                            },
                            child: RotationTransition(
                              turns: _replayController,
                              child: SvgPicture.asset(AppImages.iconReplay,
                                  colorFilter: ColorFilter.mode(
                                    Colors.white,
                                    BlendMode.srcIn,
                                  ),
                                  width: 28,
                                  height: 28),
                            ),
                          ),
                          SvgPicture.asset(AppImages.iconPreSong,
                              colorFilter: ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                              width: 28,
                              height: 28),
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
                                color: Colors.white,
                                size: 36,
                              ),
                              onPressed: _handlePlayPause,
                            ),
                          ),
                          SvgPicture.asset(AppImages.iconNext,
                              colorFilter: ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                              width: 28,
                              height: 28),
                          SvgPicture.asset(AppImages.iconShuffle,
                              colorFilter: ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                              width: 28,
                              height: 28),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(d.inMinutes.remainder(60));
    final seconds = twoDigits(d.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
