import 'package:e_learning/features/videos/data/video_item.dart';
import 'package:e_learning/features/videos/presentation/views/main_home_view.dart';
import 'package:e_learning/features/videos/presentation/views/video_player_view.dart';
import 'package:flutter/material.dart';

import 'routes.dart';

class AppRouter {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.home:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => const MainHomeView(),
        );
      case Routes.video:
        final video = settings.arguments;
        if (video is VideoItem) {
          return MaterialPageRoute(
            settings: settings,
            builder: (_) => VideoPlayerView(video: video),
          );
        }
        return _notFound(settings);
      default:
        return _notFound(settings);
    }
  }

  Route<dynamic> _notFound(RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Page not found')),
        body: const Center(child: Text('This page is not available.')),
      ),
    );
  }
}
