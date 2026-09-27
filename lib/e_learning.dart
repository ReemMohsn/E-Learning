import 'package:e_learning/core/routing/app_router.dart';
import 'package:e_learning/core/routing/navigator_key.dart';
import 'package:e_learning/core/themes/app_theme.dart';
import 'package:flutter/material.dart';

class ELearningApp extends StatelessWidget {
  const ELearningApp({
    super.key,
    required this.appRouter,
    required this.initialRoute,
  });

  final AppRouter appRouter;
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      navigatorKey: NavigatorKey.navigatorKey,

      onGenerateRoute: appRouter.generateRoute,
      initialRoute: initialRoute,
    );
  }
}
