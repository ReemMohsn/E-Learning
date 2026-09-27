import 'package:e_learning/core/constants/app_strings.dart';
import 'package:e_learning/core/routing/routes.dart';
import 'package:e_learning/features/course_videos/data/models/course_video_model.dart';
import 'package:flutter/material.dart';

class CourseVideoCard extends StatelessWidget {
  const CourseVideoCard({super.key, required this.video});

  final CourseVideoModel video;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Navigator.of(
          context,
        ).pushNamed(Routes.videoPlayer, arguments: video),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              _VideoThumbnail(imageUrl: video.thumbnailUrl),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      video.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                    if (video.description.trim().isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        video.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Semantics(
                label: AppStrings.playVideo,
                button: true,
                child: CircleAvatar(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  child: const Icon(Icons.play_arrow_rounded),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VideoThumbnail extends StatelessWidget {
  const _VideoThumbnail({this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final url = imageUrl?.trim() ?? '';
    final placeholder = ColoredBox(
      color: theme.colorScheme.secondaryContainer,
      child: Icon(
        Icons.play_lesson_outlined,
        color: theme.colorScheme.onSecondaryContainer,
        size: 30,
      ),
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: SizedBox(
        width: 68,
        height: 64,
        child: url.isEmpty
            ? placeholder
            : Image.network(
                url,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => placeholder,
              ),
      ),
    );
  }
}
