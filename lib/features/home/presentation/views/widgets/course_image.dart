import 'package:e_learning/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

class CourseImage extends StatelessWidget {
  const CourseImage({super.key, required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final url = imageUrl?.trim() ?? '';
    final uri = Uri.tryParse(url);
    final hasImage =
        uri != null &&
        (uri.scheme == 'https' || uri.scheme == 'http') &&
        uri.host.isNotEmpty;
    final placeholder = ColoredBox(
      color: theme.colorScheme.secondaryContainer,
      child: Center(
        child: Icon(
          Icons.school_outlined,
          color: theme.colorScheme.onSecondaryContainer,
          size: 36,
        ),
      ),
    );

    return ClipRRect(
      borderRadius: AppTheme.courseImageRadius,
      child: hasImage
          ? Image.network(
              url,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              excludeFromSemantics: true,
              loadingBuilder: (context, child, progress) =>
                  progress == null ? child : placeholder,
              errorBuilder: (context, error, stackTrace) => placeholder,
            )
          : placeholder,
    );
  }
}
