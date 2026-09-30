import 'package:e_learning/core/routing/app_router.dart';
import 'package:e_learning/core/routing/routes.dart';
import 'package:e_learning/e_learning.dart';
import 'package:e_learning/features/videos/data/data_list.dart';
import 'package:e_learning/features/videos/presentation/views/main_home_view.dart';
import 'package:e_learning/features/videos/presentation/views/video_player_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'home opens and selected video has its own route with a back button',
    (tester) async {
      await tester.pumpWidget(
        ELearningApp(appRouter: AppRouter(), initialRoute: Routes.home),
      );
      await tester.pumpAndSettle();
      expect(find.byType(MainHomeView), findsOneWidget);
      expect(find.byType(VideoPlayerView), findsNothing);

      await tester.tap(find.text('Video 2'));
      await tester.pumpAndSettle();
      expect(
        tester.widget<VideoPlayerView>(find.byType(VideoPlayerView)).video.id,
        videoList[1].id,
      );
      expect(find.text('Video 2'), findsNWidgets(2));
      expect(tester.takeException(), isNull);

      await tester.pageBack();
      await tester.pumpAndSettle();
      expect(find.byType(MainHomeView), findsOneWidget);
      expect(find.byType(VideoPlayerView), findsNothing);
    },
    // Exercise routing without creating a native platform WebView.
    variant: TargetPlatformVariant({TargetPlatform.windows}),
  );

  testWidgets(
    'home scrolls on a small screen with large text without overflowing',
    (tester) async {
      tester.view.physicalSize = const Size(320, 480);
      tester.view.devicePixelRatio = 1;
      tester.platformDispatcher.textScaleFactorTestValue = 2;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      await tester.pumpWidget(
        ELearningApp(appRouter: AppRouter(), initialRoute: Routes.home),
      );
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(find.text('Video 3'), 160);
      expect(find.text('Video 3'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );

  testWidgets('video route without a video shows a safe fallback', (
    tester,
  ) async {
    await tester.pumpWidget(
      ELearningApp(appRouter: AppRouter(), initialRoute: Routes.home),
    );
    final context = tester.element(find.byType(MainHomeView));
    Navigator.of(context).pushNamed(Routes.video);
    await tester.pumpAndSettle();
    expect(find.text('This page is not available.'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
