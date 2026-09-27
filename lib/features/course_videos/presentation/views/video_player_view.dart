import 'package:e_learning/core/constants/app_strings.dart';
import 'package:e_learning/features/course_videos/data/models/course_video_model.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({super.key, required this.video});

  final CourseVideoModel video;

  @override
  State<VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  late final VideoPlayerController _controller;
  late final Future<void> _initializeVideo;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(widget.video.videoUrl),
    );
    _initializeVideo = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayback() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.video.title)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FutureBuilder<void>(
                future: _initializeVideo,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ColoredBox(
                        color: Colors.black,
                        child: Center(
                          child: Text(
                            AppStrings.videoCouldNotLoad,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    );
                  }
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ColoredBox(
                        color: Colors.black,
                        child: Center(child: CircularProgressIndicator()),
                      ),
                    );
                  }
                  return ValueListenableBuilder<VideoPlayerValue>(
                    valueListenable: _controller,
                    builder: (context, value, child) {
                      final aspectRatio = value.aspectRatio > 0
                          ? value.aspectRatio
                          : 16 / 9;
                      return ColoredBox(
                        color: Colors.black,
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: aspectRatio,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  VideoPlayer(_controller),
                                  IconButton.filled(
                                    onPressed: _togglePlayback,
                                    iconSize: 42,
                                    tooltip: value.isPlaying
                                        ? AppStrings.pauseVideo
                                        : AppStrings.playVideo,
                                    icon: Icon(
                                      value.isPlaying
                                          ? Icons.pause_rounded
                                          : Icons.play_arrow_rounded,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            VideoProgressIndicator(
                              _controller,
                              allowScrubbing: true,
                              padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
                              colors: VideoProgressColors(
                                playedColor: theme.colorScheme.primary,
                                bufferedColor: Colors.white54,
                                backgroundColor: Colors.white24,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.video.title,
                      style: theme.textTheme.headlineSmall,
                    ),
                    if (widget.video.description.trim().isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        widget.video.description,
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
